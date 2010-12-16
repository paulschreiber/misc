#!/usr/bin/perl

# m3u2mp3
# takes an .m3u file and downloads the .mp3s
# this is a quick hack, no real error checking
#
# needs: grep, xargs, curl
#
# Paul Schreiber
# http://paulschreiber.com/
# misc at paulschreiber.com
#
# Released 8 April 2003
#

if ($#ARGV != 0) {
	print "Usage: $0 <m3u file>\n";
	exit;
}

$filePath = $ARGV[0];
$command = "/usr/bin/grep ^http: " . $filePath;
$command2 = $command . " | /usr/bin/xargs -n 1 /usr/bin/curl -O";

$result = `$command`;

if ($result ne "") {
	`$command2`;
} else {
	print "No URLs found in $filePath.\n";
}
