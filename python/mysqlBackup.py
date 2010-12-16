#!/usr/bin/python

## MySQL backup
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0 -- 27 February 2007
##
## Licensed under a CreativeCommons-Attribution License:
## http://creativecommons.org/licenses/by/2.5/
##
##

import MySQLdb
import commands
import sys
import time
import os

def createBackupDirectory(basePath):
	today = time.strftime("%Y-%m-%d", time.localtime())
	todaysPath = basePath + today + "/"

	if (not os.path.exists(basePath)):
		try:
			os.mkdir(basePath)
		except:
			print "Could not create backup directory [%s]" % (basePath)
			sys.exit(-1)


	if (not os.path.exists(todaysPath)):
		try:
			os.mkdir(todaysPath)
			os.chdir(todaysPath)
		except:
			print "Could not create backup directory [%s]" % (todaysPath)
			sys.exit(-2)
	
	return todaysPath

def getDatabaseList():
	try:
		db = MySQLdb.connect(host=dbHost, user=dbUser, passwd=dbPassword, db="mysql")
	except:
		print "Could not connect to 'mysql' database [%s@%s]" % (dbUser, dbHost)
		sys.exit(-3)

	cursor = db.cursor()
	cursor.execute("SELECT Db FROM db")
	tmpDatabaseList = cursor.fetchall()
	cursor.close()
	
	databaseList = []
	for currentDatabase in tmpDatabaseList:
		databaseList.append(currentDatabase[0])
	
	return databaseList

def backupDb(todaysPath, currentDatabase):
	backupFile = currentDatabase + ".sql"
	zipFile = currentDatabase + ".tgz"
	backupFilePath = todaysPath + backupFile
	commands.getoutput("/usr/bin/mysqldump --host=%s --user=%s --password=%s %s > %s" % (dbHost, dbUser, dbPassword, currentDatabase, backupFilePath))	
	os.chdir(todaysPath)
	commands.getoutput("/bin/tar cfz %s %s" % (zipFile, backupFile))	
	os.remove(backupFilePath)

def makeBasePath(path):
	# add trailing slash if needed
	if (path[-1] != os.sep):
		path += os.sep

	# handle absolute paths
	if (path[0] == os.sep or path[0] == "~"):
		return path

	# handle relative paths
	else:
		return os.getcwd() + os.sep + path

if (len(sys.argv) < 3 or len(sys.argv) > 5):
	print "Usage: %s <backupPath> <password> [<user>] [<hostname>]" % sys.argv[0]
	sys.exit()

basePath = makeBasePath(sys.argv[1])
dbPassword = sys.argv[2]

if (len(sys.argv) > 3):
	dbUser = sys.argv[3]
else:
	dbUser = "root"

if (len(sys.argv) > 4):
	dbHost = sys.argv[4]
else:
	dbHost = "localhost"

commands.getoutput("/usr/bin/mysqlcheck --all-in-1 --silent --all-databases --auto-repair --optimize --host=%s --user=%s --password=%s" % (dbHost, dbUser, dbPassword))
todaysPath = createBackupDirectory(basePath)
databaseList = getDatabaseList()
for currentDatabase in databaseList:
	backupDb(todaysPath, currentDatabase)