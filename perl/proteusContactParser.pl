#!/usr/bin/perl -w

## Proteus Contact List Parser
## 
## Paul Schreiber <misc at paulschreiber dot com>
## http://paulschreiber.com/
## 1.0 30 May 2004
## 1.1 02 June 2004
##    - refactored into nice functions
##    - now supports nested groups
##
##

use Foundation;
use strict;
use diagnostics;

sub printContact {
	my ($contactDict, $depth, $totals, %accountHash) = @_;
	my ($contactData, $contactName, $contacts);
	my ($account, $accounts, $accountEnum, $accountId, $accountType);

	$contactData = $contactDict->objectForKey_("Data");
	if (!$contactData or !$$contactData) {
		return;
	}

	$contactName = $contactDict->objectForKey_("Name");
	if (!$contactName or !$$contactName) {
		$contactName = NSString->stringWithUTF8String_("[no name]");
	}

	print "\t"x$depth . $contactName->UTF8String() . "\n";
	$$totals[1]++;

	$accountEnum = $contactData->objectEnumerator();

	## iterate over the accounts in each contact
	while ($account = $accountEnum->nextObject()) {
		if (!$account or !$$account) {
			last;
		}

		$accountId = $account->objectForKey_("Identifier");

		if (!$accountId or !$$accountId) {
			next;
		}

		$accountType = $account->objectForKey_("Account Identifier")->intValue();

		print "\t"x($depth+1)."[";
		print $accountHash{$accountType};
		print "] " .  $accountId->UTF8String() .  "\n";
		
		$$totals[2]++;
	}

}

sub printGroup {
	my ($item, $depth, $totals, %accountHash) = @_;
	my ($groups, $groupName, $groupArray, $groupEnum);
	my ($contactDict, $contactType);

	$groupName = $item->objectForKey_("Name");
	$groupArray = $item->objectForKey_("Data"); # array of dictionaries
	$groupEnum = $groupArray->objectEnumerator();

	print "\t"x$depth . $groupName->UTF8String() . "\n";
	$$totals[0]++;

	## iterate over the contacts in each group
	while ($contactDict = $groupEnum->nextObject()) {
		if (!$contactDict or !$$contactDict) {
			last;
		}

		$contactType = $contactDict->objectForKey_("Type");

		if ($contactType->UTF8String() eq "Group") {
			printGroup($contactDict, $depth+1, $totals, %accountHash);
		} elsif ($contactType->UTF8String() eq "Contact Group") {
			printContact($contactDict, $depth+1, $totals, %accountHash);
		} else {
			die "Unknown item in group: ".$groupName->UTF8String()."\n";
		}		
	}

}

##
## main logic
##

if ( scalar(@ARGV) != 1) {
	die "Usage: $0 /path/to/ContactList.plist\n";
}

my $file = $ARGV[0];
my $dict = NSDictionary->dictionaryWithContentsOfFile_($file);

if (!$dict or !$$dict) {
	die "bad plist file [$file]\n";
}

## variables used in the main loop
my ($item, $itemType, $itemName);
my (@totals) = (0,0,0);

## update this hash to match your accounts
my %accountHash = (
	10 => "ICQ",
	11 => " Y!",
	12 => "MSN",
	13 => "AIM",
);

## iterate over the groups
my $mainArray = $dict->objectForKey_("Data");
my $enumerator = $mainArray->objectEnumerator();

while ($item = $enumerator->nextObject()) {
	if (!$item or !$$item) {
		last;
	}

	$itemType = $item->objectForKey_("Type");

	if ($itemType->UTF8String() eq "Group") {
		print $item->objectForKey_("Name")->UTF8String() . "\n";
		printGroup($item, 0, \@totals, %accountHash);
		
	} elsif ($itemType->UTF8String() eq "Contact Group") {
		printContact($item, 0, \@totals, %accountHash);
		
	} else {
		die "Unknown item in main list:" . $itemType->UTF8String() . "\n";
	}

}

print "\nTotals: Groups: $totals[0]. Contacts: $totals[1]. Accounts: $totals[2].\n";
