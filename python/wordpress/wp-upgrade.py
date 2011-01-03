#!/usr/bin/python

## WordPress batch upgrade
## Inspired by Scot Hacker <http://birdhouse.org/>
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0  -- 3 January 2011
## 1.01  -- 3 January 2011; fixed Akismet copying
##
## Licensed under the MIT License
##
##


import os
import commands
import sys
import tempfile
import shutil

script_path     = os.getcwd()
sites_path      = "%s/wp-sites.txt" % (script_path)
notice_path     = "%s/wp-upgrade.txt" % (script_path)

if len(sys.argv) < 2:
	print "Usage: %s wp_version [temp_path]"
	sys.exit()

wp_version = sys.argv[1]

if not os.path.exists(notice_path):
	print "Cannot find upgrade notice (%s)" % (notice_path)
	sys.exit()

if not os.path.exists(sites_path):
	print "Cannot find site list (%s)" % (sites_path)
	sys.exit()
else:
	sites = []
	sites_data = open(sites_path).read().split("\n")
	for s in sites_data:
		current_site_data = s.split("\t")
		if len(current_site_data) > 3: sites.append(current_site_data)

wp_svn_url      = "http://svn.automattic.com/wordpress/tags/%s/" % (wp_version)
akismet_svn_url = "http://plugins.svn.wordpress.org/akismet/trunk"
svn             = "/usr/bin/svn"
sendmail        = "/usr/sbin/sendmail"


def send_email_notification(notice_path, recipient, wp_version, url):
	print "Emailing %s" % (recipient)
	notice_text = open(notice_path).read()
	notice_text = notice_text.replace("__version__", wp_version)
	notice_text = notice_text.replace("__recipient__", recipient)
	notice_text = notice_text.replace("__url__", url)
	
	p = os.popen("%s -t" % sendmail, "w")
	p.write(notice_text)
	p.close()


def fetch_source(temp_directory):
	os.chdir(temp_directory)
	print "Fetching %s" % (wp_svn_url)
	print "Fetching %s" % (akismet_svn_url)
	commands.getoutput("%s export '%s'" % (svn, wp_svn_url))
	commands.getoutput("%s export '%s'" % (svn, akismet_svn_url))
	
	if os.path.exists("readme.html"): os.remove("%s/readme.html" % (wp_version))
	if os.path.exists("license.txt"): os.remove("%s/license.txt" % (wp_version))
	if os.path.exists("wp-config-sample.php"): os.remove("%s/wp-config-sample.php" % (wp_version))


##
## Optionally pass in the path to the WordPress and Akismet SVN exports
## if it exists, use that; else, make a temporary directory and fetch
## WordPress and Akismet
##

remove_temp_directory = True
if len(sys.argv) > 2:
	temp_directory = sys.argv[2]
	if os.path.exists(temp_directory):
		print "Using %s" % (temp_directory)
		remove_temp_directory = False
	else:
		temp_directory = None
else:
	temp_directory = None

if temp_directory == None:
	temp_directory = tempfile.mkdtemp()
	print "Creating %s" % (temp_directory)
	fetch_source(temp_directory)

akismet_directory    = temp_directory    + "/" + "trunk"
wp_temp_directory    = temp_directory    + "/" + wp_version
wp_include_directory = wp_temp_directory + "/" + "wp-includes"
wp_admin_directory   = wp_temp_directory + "/" + "wp-admin"

print "temp directory is %s" % (temp_directory)
print "wp temp directory is %s" % (wp_temp_directory)

for site in sites:
	(path, url, recipient, user) = site

	print "Updating %s..." % (url)

	## replace Akismet
	akismet_path = "%s/wp-content/plugins/akismet" % (path)
	if os.path.exists(akismet_path): shutil.rmtree(akismet_path)
	os.makedirs(akismet_path)
	commands.getoutput("cp -r '%s'/* '%s'" % (akismet_directory, akismet_path))
	# print "cp -r '%s'/*' '%s'" % (akismet_directory, akismet_path)

	## replace wp-includes and wp-admin
	site_wp_include_path = "%s/wp-includes" % (path)
	site_wp_admin_path = "%s/wp-admin" % (path)
	if os.path.exists(site_wp_include_path): shutil.rmtree(site_wp_include_path)
	if os.path.exists(site_wp_admin_path): shutil.rmtree(site_wp_admin_path)
	shutil.copytree(wp_admin_directory, site_wp_admin_path)
	shutil.copytree(wp_include_directory, site_wp_include_path)
	
	## replace WordPress .php files
	commands.getoutput("cp -rf '%s/*.php' '%s'" % (wp_temp_directory, path))
	# print "cp -rf '%s/*.php' '%s'" % (wp_temp_directory, path)
	
	## create the upload directory, if needed
	upload_path = "%s/wp-content/uploads" % (path)
	if not os.path.exists(upload_path): os.makedirs(upload_path)
	
	## fix permissions
	commands.getoutput("chown -R %s:%s '%s'" % (user, user, path))
	commands.getoutput("chown -R %s:www-data '%s/wp-content/uploads'" % (user, path))
	commands.getoutput("chgrp -R g+w '%s/wp-content/uploads'" % (path))
	
	# print "chown -R %s:%s '%s'" % (user, user, path)
	# print "chown -R %s:www-data '%s/wp-content/uploads'" % (user, path)
	# print "chgrp -R g+w '%s/wp-content/uploads'" % (path)
	
	## notify users of upgrade
	send_email_notification(notice_path, recipient, wp_version, url)


if (remove_temp_directory == True) and os.path.exists(temp_directory):
	shutil.rmtree(temp_directory)
