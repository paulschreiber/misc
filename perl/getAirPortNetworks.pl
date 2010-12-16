#!/usr/bin/perl -w

## AirPort Network Parser
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0 -- 1 August 2004
## 1.1 -- 11 October 2004
##     -- now allows you to remove unwanted networks
##     -- the new file gets written to /tmp/
##
##

use Foundation;
use strict;
use diagnostics;

my ($prefFilePath, $prefFileDict, $replacementPrefFilePath);
my ($apPlistDataBlock, $apPlistString, $apPlistArray, $apPlistEnumerator);

$prefFilePath = "/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist";
$replacementPrefFilePath = "/tmp/com.apple.airport.preferences.plist";
$prefFileDict = NSMutableDictionary->dictionaryWithContentsOfFile_($prefFilePath);

$apPlistDataBlock = $prefFileDict->objectForKey_("APNetStack");

# NSUTF8StringEncoding = 4
$apPlistString = NSString->alloc()->initWithData_encoding_($apPlistDataBlock, 4);

#to debug, uncomment
#print $apPlistString->UTF8String();

$apPlistArray = $apPlistString->propertyList();

if ( $apPlistArray->count() > 0 ) {

	print "AirPort networks you have joined:\n";

	$apPlistEnumerator = $apPlistArray->objectEnumerator();

	my ($currentArrayItem, $ssidData, $ssid);
	my ($keyLength, $timeStamp, $authMode, $cipherMode, $isIBSS);
	my ($keepNetwork);
	
	while ($currentArrayItem = $apPlistEnumerator->nextObject()) {
		if ((! $currentArrayItem) or (! $$currentArrayItem)) {
			last;
		}
		
		$ssidData = $currentArrayItem->objectForKey_("SSID");
		$ssid = NSString->alloc()->initWithData_encoding_($ssidData, 4);
		
		$keyLength = $currentArrayItem->objectForKey_("WEPKeyLen");
		$timeStamp = $currentArrayItem->objectForKey_("_timeStamp");
		$authMode = $currentArrayItem->objectForKey_("authMode");
		$cipherMode = $currentArrayItem->objectForKey_("cipherMode");
		$isIBSS = $currentArrayItem->objectForKey_("isIBSS");
	
		print "Keep the network " . $ssid->UTF8String() . "? [y/n] ";
#		print "\tKL: " . $keyLength->description->UTF8String() . "\n";
#		print "\tTS: " . $timeStamp->description->UTF8String() . "\n";
#		print "\tAM: " . $authMode->description->UTF8String() . "\n";
#		print "\tCM: " . $cipherMode->description->UTF8String() . "\n";
#		print "\tIB:" . $isIBSS->description->UTF8String() . "\n";

		$keepNetwork = <STDIN>;
		chomp($keepNetwork);
		if ($keepNetwork eq "n" || $keepNetwork eq "N") {
			$apPlistArray->removeObject_($currentArrayItem);
		}
	}

	$apPlistArray->writeToFile_atomically_($replacementPrefFilePath, 0) || die "Couldn't write inner plist back to file";
	my $apPlistData = NSData->dataWithContentsOfFile_($replacementPrefFilePath);
	$prefFileDict->setObject_forKey_($apPlistData, "APNetStack");
	$prefFileDict->writeToFile_atomically_($replacementPrefFilePath, 0) || die "Couldn't write full plist back to file";
	

	exit;	
}

print "You have not joined any AirPort networks.\n";