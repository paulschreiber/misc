#!/usr/bin/python

## WordPress batch upgrade
## Inspired by Scot Hacker <http://birdhouse.org/>
##
## Paul Schreiber <misc at paulschreiber dot com>
## https://paulschreiber.com/
## 1.0  -- 3 January 2011
## 1.01 -- 3 January 2011; fixed Akismet copying
## 1.1  -- 3 January 2011; refactoring; require root
## 1.2  -- 4 February 2011;
##  * can specify --akismet-only or --wordpress-only
##  * suppress notifications with --quiet
##  * now use --path for path
## 1.3 -- 29 December 2014:
##  * use https URLs
## 1.4 -- 21 September 2017:
##  * check for subversion binary
## 1.5 -- 2 December 2019
##  * rewritten to use wp CLI
##  * updates database, plugins and themes
## Licensed under the MIT License
##
##


import os
import commands
import sys
import getopt

sendmail = "/usr/sbin/sendmail"
wp_cli   = "/usr/local/bin/wp"

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

def update_site(site_path, user):
	os.chdir(site_path)

	old_version = commands.getoutput("sudo -u %s -- wp core version" % (user))
	commands.getoutput("sudo -u %s --  wp core update" % (user))
	new_version = commands.getoutput("sudo -u %s -- wp core version" % (user))
	wp_updated = old_version != new_version

	commands.getoutput("sudo -u %s -- wp core update-db" % (user))
	commands.getoutput("sudo -u %s -- wp plugin update --all" % (user))
	commands.getoutput("sudo -u %s -- wp theme update --all" % (user))

	return (wp_updated, new_version)

def usage():
	print "Usage: %s wp_version [-q|--quiet]" % (sys.argv[0])
	sys.exit()

def main():
	try:
		opts, args = getopt.getopt(sys.argv[2:], "q:", ["quiet"])
	except getopt.GetoptError, err:
		# print help information and exit:
		print str(err) # will print something like "option -a not recognized"
		usage()

	notify = True

	for o, a in opts:
		if o in ("-q", "--quiet"):
			notify = False
		else:
			assert False, "unhandled option"

	if not os.geteuid() == 0:
		print "%s must be run as root" % (sys.argv[0])
		sys.exit()

	if not os.path.isfile(wp_cli):
		print "wp is not installed at [%s]" % (wp_cli)
		exit()

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

	sites = read_site_list(sites_path)

	for site_info in sites:
		(site_path, url, recipient, user) = site_info

		print "Updating %s..." % (url)
		(wp_updated, wp_version) = update_site(site_path, user)

		if notify and wp_updated:
			print "Emailing %s..." % (recipient)
			send_email_notification(notice_path, recipient, wp_version, url)


if __name__ == "__main__":
	main()

