#!/usr/bin/python

## Toronto Star crossword puzzle fetcher
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0 -- 26 December 2006
## 1.01 -- 27 February 2007. Improve path handling.
##
## Licensed under a CreativeCommons-Attribution License:
## http://creativecommons.org/licenses/by/2.5/
##
## Usage: starpm.py <directory to store crossword puzzles>
##
## Requirements
## -------------------------------------------------------------
## This requires Mac OS X. It has been tested on Mac OS X 10.4.8,
## but should work on other versions.
##
## Setup
## -------------------------------------------------------------
## To have this run automatically, use cron. Run:
## $ crontab -e
## and paste in the following line:
## 0 14 * * 1-5    /path/to/starpm.py /path/to/output/directory
##
## The number "14" represents 14:00, or 2 p.m Pacific Time., which is 5 p.m. Eastern Time.
## The Star publishs the Star PM at 3:30 PM Eastern Time. You'll need to adjust the "14"
## for your time zone.
##
## Make sure that the script has the execute bit set:
## $ chmod +x starpm.py
## ...and the user running the cron job has permission to write to the output directory.
##
## For printing to work, make sure you have a printer configured, connected, and 
## containing sufficient ink and paper.
##
## Errata
## -------------------------------------------------------------
## Users of other platforms will want to check out the pdftk or gs commands.
## This command should work:
## $ pdftk starpm8.pdf cat 8 output crossword.pdf
## ...but I received the following error:
## Error: Failed to open PDF file: 
##    starpm8.pdf
##    OWNER PASSWORD REQUIRED, but not given (or incorrect)
## Errors encountered.  No output created.
## Done.  Input errors, so no output created.
##
## If you get this working, you can redefine createCrosswordPdf().
##

import urllib
import os
import sys
import datetime
import commands
from CoreGraphics import *

# constants
pdfUrl = "http://media.thestar.com/starpm/starpm8.pdf"
crosswordPageNumber = 8
lprPath = "/usr/bin/lpr"

# print a usage message and exit
def usage():
	print "Usage: %s <directory to store crossword puzzles>" % sys.argv[0]
	sys.exit(0)
	
# download the PDF from thestar.com and save it locally
def downloadPdf(pdfUrl, fullPdfPath):
	pdfData = urllib.urlopen(pdfUrl).read()
	if (len(pdfData) < 1):
		print "Could not download PDF from thestar.com [%s]" % pdfUrl
		sys.exit(-3)

	try:
		pdfFile = open(fullPdfPath, "w")
		pdfFile.write(pdfData)
		pdfFile.close()
	except IOError:
		print "Could not write PDF [%s]" % fullPdfPath
		sys.exit(-4)

# create a new PDF consisting only of page 8, which has the crossword puzzle
def createCrosswordPdf(fullPdfPath, crosswordPdfPath, crosswordPageNumber):
	try:
		crowsswordPdf = CGPDFDocumentCreateWithProvider(CGDataProviderCreateWithFilename(fullPdfPath))
		mediaBox = crowsswordPdf.getMediaBox(crosswordPageNumber)

		c = CGPDFContextCreateWithFilename(crosswordPdfPath, mediaBox)
		c.beginPage(mediaBox)
		c.drawPDFDocument(mediaBox, crowsswordPdf, crosswordPageNumber)
		c.endPage()
		c.finish()

	except ImportError:
		print "Could not import CoreGraphics Python module"
		sys.exit(-5)

# parse the arguments
if (len(sys.argv) < 2):
	usage()
elif (sys.argv[1] == "-h" or sys.argv[1] == "-help" or sys.argv[1] == "--help"):
	usage()

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


basePath = makeBasePath(sys.argv[1])
# only compute the time once in case we're near a date rollover
currentTime = datetime.datetime.now()
yearMonthFolderPath = basePath + currentTime.strftime("%%Y%s%%m%s" % (os.sep, os.sep))
fullPdfPath = yearMonthFolderPath + currentTime.strftime("%Y-%m-%d.pdf")
crosswordPdfPath = yearMonthFolderPath + currentTime.strftime("%Y-%m-%d-crossword.pdf")

# if the crossword puzzle already exists, we're done
if (os.path.exists(crosswordPdfPath)):
	print "The crossword for today has already been downloaded and processed. [%s]" % crosswordPdfPath
	sys.exit(0)

if (not os.path.exists(fullPdfPath)):
	if (not os.path.exists(yearMonthFolderPath)):
		try:
			os.makedirs(yearMonthFolderPath)
		except OSError:
			print "Could not create a folder to store the PDF in [%s]" % yearMonthFolderPath
			sys.exit(-1)

	if (not os.path.exists(yearMonthFolderPath)):
		print "Could not create a folder to store the PDF in [%s]" % yearMonthFolderPath
		sys.exit(-2)
	
	downloadPdf(pdfUrl, fullPdfPath)

if (not os.path.exists(fullPdfPath)):
	print "Downloading the PDF failed"
	sys.exit(-6)

createCrosswordPdf(fullPdfPath, crosswordPdfPath, crosswordPageNumber)

if (not os.path.exists(crosswordPdfPath)):
	print "Creating the crossword PDF failed"
	sys.exit(-7)

try:
	os.remove(fullPdfPath)
except OSError:
	print "Removing the full PDF failed [%s]" % fullPdfPath

# print the crossword PDF
commands.getoutput("%s %s" % (lprPath, crosswordPdfPath))