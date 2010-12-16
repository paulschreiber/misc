#!/usr/bin/python

# txt2vcf
# takes a tab-delimited text file with four columns
#     nickname, first name, last name, email
# and generates a vCard (.vcf) file
#
# Paul Schreiber
# http://paulschreiber.com/
# misc at paulschreiber.com
#
# Released 8 April 2003
#


import string
import re
import sys

if len(sys.argv) != 2:
	print 'Usage: %s <textfile>' % sys.argv[0]
	sys.exit()

inputFile = sys.argv[1]
outputFile = inputFile + '.vcf'

data = open(inputFile).readlines()
outFile = open(outputFile, 'w')

for line in data:
	(nick, first, last, email) = string.split(line, "\t")[:-1]
	outFile.write( 'BEGIN:VCARD' + '\n' )
	outFile.write( 'VERSION:3.0' + '\n' )
	outFile.write( 'N:%s;%s;;;' % (last, first) + '\n' )
	outFile.write( 'FN:%s %s' % (first, last) + '\n' )
	outFile.write( 'TITLE:%s' % nick + '\n' )
	outFile.write( 'EMAIL:%s' % email + '\n' )
	outFile.write( 'END:VCARD' + '\n')
