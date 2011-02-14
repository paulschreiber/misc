#!/usr/bin/python

## WordPress batch upgrade
## Inspired by Scot Hacker <http://birdhouse.org/>
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0  -- 3 January 2011
## 1.01 -- 3 January 2011; fixed Akismet copying
## 1.1  -- 3 January 2011; refactoring; require root
## 1.2  -- 4 February 2011;
##  * can specify --akismet-only or --wordpress-only
##  * suppress notifications with --quiet
##  * now use --path for path
##
## Licensed under the MIT License
##
##


import os
import commands
import sys
import tempfile
import shutil
import getopt

svn             = "/usr/bin/svn"
sendmail        = "/usr/sbin/sendmail"

def read_site_list(sites_path):
	sites = []
	sites_data = open(sites_path).read().split("\n")
	for s in sites_data:
		current_site_data = s.split("\t")
		# skip incomplete or commented-out lines
		if len(current_site_data) > 3 and current_site_data[0][0] != "#":
			sites.append(current_site_data)
	return sites
			
def send_email_notification(notice_path, recipient, wp_version, url):
	notice_text = open(notice_path).read()
	notice_text = notice_text.replace("__version__", wp_version)
	notice_text = notice_text.replace("__recipient__", recipient)
	notice_text = notice_text.replace("__url__", url)
	
	p = os.popen("%s -t" % sendmail, "w")
	p.write(notice_text)
	p.close()


def fetch_wp(wp_version, temp_directory):
	wp_svn_url = "http://svn.automattic.com/wordpress/tags/%s/" % (wp_version)
	os.chdir(temp_directory)
	print "Fetching %s" % (wp_svn_url)
	commands.getoutput("%s export '%s'" % (svn, wp_svn_url))
	if os.path.exists("readme.html"):          os.remove("%s/readme.html" % (wp_version))
	if os.path.exists("license.txt"):          os.remove("%s/license.txt" % (wp_version))
	if os.path.exists("wp-config-sample.php"): os.remove("%s/wp-config-sample.php" % (wp_version))

def install_wp(site_path, wp_src_path, user):
	# fresh copy of WordPress
	wp_include_src_path = "%s/wp-includes" % (wp_src_path)
	wp_admin_src_path   = "%s/wp-admin"    % (wp_src_path)

	# existing (old) copy of WordPress
	site_wp_include_path = "%s/wp-includes" % (site_path)
	site_wp_admin_path   = "%s/wp-admin"    % (site_path)
	
	## replace wp-includes and wp-admin
	if os.path.exists(site_wp_include_path): shutil.rmtree(site_wp_include_path)
	if os.path.exists(site_wp_admin_path):   shutil.rmtree(site_wp_admin_path)
	shutil.copytree(wp_admin_src_path, site_wp_admin_path)
	shutil.copytree(wp_include_src_path, site_wp_include_path)
	
	## replace WordPress .php files
	commands.getoutput("cp -rf '%s/*.php' '%s'" % (wp_src_path, site_path))
	# print "cp -rf '%s/*.php' '%s'" % (wp_src_path, site_path)
	
	## create the upload directory, if needed
	upload_path = "%s/wp-content/uploads" % (site_path)
	if not os.path.exists(upload_path): os.makedirs(upload_path)
	
	## fix permissions
	commands.getoutput("chown -R %s:%s '%s'" % (user, user, site_path))
	commands.getoutput("chown -R %s:www-data '%s/wp-content/uploads'" % (user, site_path))
	commands.getoutput("chgrp -R g+w '%s/wp-content/uploads'" % (site_path))
	
	# print "chown -R %s:%s '%s'" % (user, user, site_path)
	# print "chown -R %s:www-data '%s/wp-content/uploads'" % (user, site_path)
	# print "chgrp -R g+w '%s/wp-content/uploads'" % (site_path)

def fetch_akismet(temp_directory):
	akismet_svn_url = "http://plugins.svn.wordpress.org/akismet/trunk"
	os.chdir(temp_directory)
	print "Fetching %s" % (akismet_svn_url)
	commands.getoutput("%s export '%s'" % (svn, akismet_svn_url))


def install_akismet(site_path, akismet_src_path):
	akismet_path = "%s/wp-content/plugins/akismet" % (site_path)
	if os.path.exists(akismet_path): shutil.rmtree(akismet_path)
	os.makedirs(akismet_path)
	commands.getoutput("cp -r '%s'/* '%s'" % (akismet_src_path, akismet_path))
	# print "cp -r '%s'/*' '%s'" % (akismet_src_path, akismet_path)

def usage():
	print "Usage: %s wp_version [-q|--quiet] [-a|--akimset-only] [-w|--wordpress-only] [-p|--path=temp_path]" % (sys.argv[0])
	sys.exit()

def main():
	try:
		opts, args = getopt.getopt(sys.argv[2:], "qawp:", ["quiet", "akimset-only", "wordpress-only", "path="])
	except getopt.GetoptError, err:
		# print help information and exit:
		print str(err) # will print something like "option -a not recognized"
		usage()

	wordpress = True
	akismet = True
	requested_temp_path = None
	notify = True
	if len(sys.argv) > 1:
		wp_version = sys.argv[1]
	else:
		wp_version = None
		
	for o, a in opts:
		if o in ("-q", "--quiet"):
			notify = False
		elif o in ("-a", "--akismet-only"):
			wordpress = False
		elif o in ("-w", "--wordpress-only"):
			akismet = False
		elif o in ("-p", "--path"):
			requested_temp_path = a
		else:
			assert False, "unhandled option"

	if not os.geteuid() == 0:
		print "%s must be run as root" % (sys.argv[0])
		sys.exit()

	if wp_version == None:
		usage()

	##
	## Confirm the existence of required files
	##
	
	script_path     = os.getcwd()

	notice_path     = "%s/wp-upgrade.txt" % (script_path)
	if notify and not os.path.exists(notice_path):
		print "Cannot find upgrade notice (%s)" % (notice_path)
		sys.exit()

	sites_path      = "%s/wp-sites.txt"   % (script_path)
	if not os.path.exists(sites_path):
		print "Cannot find site list (%s)" % (sites_path)
		sys.exit()

	##
	## If --path is specified, assume the sources are there
	## Otherwise, create a temp directory and fetch the sources
	##
	
	remove_temp_directory = True
	temp_directory = None

	if requested_temp_path and os.path.exists(requested_temp_path):
		print "Using %s" % (requested_temp_path)
		temp_directory = requested_temp_path
		remove_temp_directory = False


	if temp_directory == None:
		temp_directory = tempfile.mkdtemp()
		print "Creating %s" % (temp_directory)

		if wordpress:
			fetch_wp(wp_version, temp_directory)

		if akismet:
			fetch_akismet(temp_directory)


	##
	## Install the downloaded components, notifying if needed
	##

	wp_src_path = "%s/%s" % (temp_directory, wp_version)
	akismet_src_path = "%s/trunk" % (temp_directory)

	sites = read_site_list(sites_path)

	for site_info in sites:
		(site_path, url, recipient, user) = site_info

		print "Updating %s..." % (url)
		if akismet: install_akismet(site_path, akismet_src_path)
		if wordpress: install_wp(site_path, wp_src_path, user)

		if notify:
			print "Emailing %s..." % (recipient)
			send_email_notification(notice_path, recipient, wp_version, url)

	if (remove_temp_directory == True) and os.path.exists(temp_directory):
		shutil.rmtree(temp_directory)


if __name__ == "__main__":
	main()

