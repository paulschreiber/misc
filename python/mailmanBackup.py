#!/usr/bin/python

## Mailman backup
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0  -- 30 August 2006
## 1.01 -- 27 February 2007. Internal cleanup. No feature changes.
##
## Licensed under a CreativeCommons-Attribution License:
## http://creativecommons.org/licenses/by/2.5/
##
##

import commands
import shutil
import os
import smtplib
import sys
import time
from email.MIMEMultipart import MIMEMultipart
from email.MIMEMultipart import MIMEBase
from email.Encoders import encode_base64

def emailBackup(messageSubject, messageSender, messageRecipient, zipfilePath):
	zip = MIMEBase.MIMEBase("application", "zip")
	zip.set_payload(open(zipfilePath, "rb").read())
	encode_base64(zip)
	zip.add_header("Content-Disposition", "attachment", filename=os.path.basename(zipfile))

	message = MIMEMultipart()
	message["Subject"] = messageSubject
	message["From"] = messageSender
	message["To"] = messageRecipient
	message.attach(zip)
	s = smtplib.SMTP()
	s.connect()
	s.sendmail(messageSender, messageRecipient, message.as_string())
	s.close()

def removeBackup(backupDirectoryPath, zipfilePath):
	shutil.rmtree(backupDirectoryPath)
	os.remove(zipfilePath)

def performBackup(backupDirectoryPath, backupDirectory, listName, zipfilePath):
	listMemberFile = "list-members.txt"
	listConfigFile = "list-config.txt"

	if (not os.path.exists(backupDirectoryPath)):
		os.mkdir(backupDirectoryPath)
	
	os.chdir(backupDirectoryPath)
	commands.getoutput('/usr/sbin/list_members -f -o "%s" %s' % (listMemberFile, listName))
	commands.getoutput('/usr/sbin/config_list -o "%s" %s' % (listConfigFile, listName))
	os.chdir(temporaryDirectory)
	commands.getoutput('/usr/bin/zip  "%s" "%s/%s" "%s/%s"' % (zipfilePath, backupDirectory, listMemberFile, backupDirectory, listConfigFile))

# print a usage message and exit
def usage():
	print "Usage: %s <listname> <recipient> [<sender>]" % sys.argv[0]
	sys.exit(0)


# parse the arguments
if (len(sys.argv) < 3 or len(sys.argv) > 4):
	usage()
elif (sys.argv[1] == "-h" or sys.argv[1] == "-help" or sys.argv[1] == "--help"):
		usage()

listName = sys.argv[1]
messageRecipient = sys.argv[2]
if (len(sys.argv) > 3):
	messageSender = sys.argv[3]
else:
	messageSender = messageRecipient

## calculated values
temporaryDirectory = "/tmp/"
backupDate = time.strftime("%Y-%m-%d", time.localtime())
backupDirectory = "%s-list-%s" % (listName, backupDate)
backupDirectoryPath = temporaryDirectory + backupDirectory
zipfilePath = backupDirectoryPath + ".zip"
messageSubject = "%s mailing list backup (%s)" % (listName, backupDate)


performBackup(backupDirectoryPath, backupDirectory, listName, zipfilePath)
emailBackup(messageSubject, messageSender, messageRecipient, zipfilePath)
removeBackup(backupDirectoryPath, zipfilePath)
