#!/usr/bin/perl

######################################################
##
## Recurse 1.1
## May 16, 1999
## by Paul Schreiber <misc at paulschreiber.com>
## http://paulschreiber.com/
##
## This is free, and you're welcome to reuse and modify it. All I
## ask is that you let me know you're using it.
##
## Oh yeah, there's no warranty of any kind, blah blah blah.
## Whatever I say, goes! Got it? Good.
## I'm definitely not responsible for your use, misuse or inability
## to use this script.
##
## Revision history
## 1.1: improved error checking and error messages
##


## Cwd is required to get the current directory
use Cwd;

#######################################################################
##
## subroutine that checks if we're in the right spot in the file 
##
sub atTheSpot {

    ## in this example we check to see if the line does not
    ## begin with // -- i.e. it isn't a comment
    ## you may want to change this
    return (!($_ =~ "^//"));
}

#######################################################################
##
##  subroutine that handles the inserting
##
sub insertIntoFile {
    my($fileName, $readyToChange, $changesMade, $old, $new, $bak);
    ($fileName) = @_;

    ## readyToChange indicates we are at the spot in the file where the line
    ##    gets inserted
    ## changesMade indicates the line has been inserted into the file
    $readyToChange = 0;
    $changesMade = 0;

    $old = $fileName;
    $new = "$fileName.tmp.$$";
    $bak = "$fileName.bak";

    open(OLD, "< $old")         or die "Error: can't open file [$old].\n[$!]";
    open(NEW, "> $new")         or die "Error: can't open file [$new].\n[$!]";

    while (<OLD>) {

	if ( atTheSpot() && (! $changesMade) ) {
	    $readyToChange = 1;
	}

	if ((! $changesMade) && $readyToChange) {
	    print NEW "\n$insertMe\n\n";
	    $changesMade = 1;
	    print NEW $_;
	} else {
	    (print NEW $_)      or die "Error: can't write to file [$new].\n[$!]";
	}
    }

    close(OLD)          or die "Error: can't close file [$old].\n[$!]";
    close(NEW)          or die "Error: can't close file [$new].\n[$!]";

    rename($old, $bak)  or die "Error: can't rename file [$old] to $bak.\n[$!]";
    rename($new, $old)  or die "Error: can't rename file [$new] to $old.\n[$!]";

    ## uncomment this line to delete the backup files
    #unlink($bak)       or die "Error: can't delete file [$bak].\n[$!]";
}

#######################################################################
##
##  subroutine that will go through a directory and update all the files
##
sub directoryInsert {
    my(@theFiles, $count, $currentDirectory);

    ## get a list of all the files to be changes
    opendir(DIR, ".");
    @theFiles = grep(/$filePattern/, readdir(DIR));
    close(DIR);

    die "Error: there are no files that match the pattern in the current directory.\n" unless (scalar(@theFiles));

    $count = 1;

    ## get the current directory
    $currentDirectory = cwd;

    print "\nThe current directory is [$currentDirectory]\n";

    ## loop through all of the files
    foreach $item (@theFiles) {
	$item = "$currentDirectory/$item";
	print "file $count: $item\n";
	$count++;

	insertIntoFile($item);
    }

}

#######################################################################
##
## subroutine to do the recursion
##
sub goDirectory {
    my (@files, $item, $name, $dir);
    ($dir) = @_;

    ## insert the line into all the files in the current directory
    directoryInsert();

    if (-d _) {

	## list all of the files that don't begin with a .
	opendir(DIR, ".");
	@files = grep(! /^\./, readdir(DIR));
	close(DIR);
	
	foreach $item (@files) {

	    ## call lstat so we can use the _ variable
	    lstat($item);

	    $name = "$dir/$item";

	    ## ignore files (non-directories)
	    next if (! -d _);
	    
	    ## recurse on the directory
	    chdir($name);
	    goDirectory($name);
	    chdir("..");

	}
    }
}


#######################################################################
##
## main section of code
##

## string to be inserted
$insertMe = "PUT STRING HERE"; 

## type of files to change (for example, ending in .C)
## you may want to change this
$filePattern = "\.C\$";

## get the current path
$currentDir = cwd;
print "Starting directory is [$currentDir]\n";

## call lstat so we can use the _ variable
## inside the goDirectory() subroutine
lstat($currentDir);

## recurse!
goDirectory($currentDir);

print "\nFile updating complete.\n\n";
