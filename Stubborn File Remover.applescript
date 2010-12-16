(*
  Stubborn file remover
  by Paul Schreiber
  http://paulschreiber.com/
  web@paulschreiber.com
  
  requires Mac OS X. tested on 10.2.1, but should work on earlier versions.
  
  2 November 2002 -- 1.0
   -- initial release
   
  9 November 2002 -- 1.1
    -- now handles files via drag and drop 
    -- will chown and chmod the parent folder
    -- uses chflags recursively
*)

property newline : ASCII character 10
property tmpfile : "/tmp/sfr000000"
property rmBin : "/bin/rm"

property ownerBin : "/usr/sbin/chown"
property idBin : "/usr/bin/id"

property permsBin : "/bin/chmod"
property permsParams : "-R u+rwx"

property flagsBin : "/usr/bin/chflags"
property flagsParams : "-R nouchg"

on run
	display dialog Â
		"Are you having trouble deleting a file or folder?" buttons {"Cancel", "File", "Folder"} Â
		default button "Folder" with icon 2
	
	if button returned of result is "File" then
		choose file with prompt "Select the file you cannot delete:"
	else if button returned of result is "Folder" then
		choose folder with prompt "Select the folder you cannot delete:"
	end if
	set theTargetAlias to result
	
	prepTemp()
	fixItem(theTargetAlias)
	runTemp()
end run

on open draggeditems
	prepTemp()
	repeat with thisItem in (draggeditems as list)
		fixItem(thisItem)
	end repeat
	runTemp()
end open

on fixItem(theTargetAlias)
	try
		set theParentAlias to getParent(theTargetAlias as string)
		set theTargetPath to POSIX path of theTargetAlias
		set theParentPath to POSIX path of theParentAlias
		
		set myUid to word 3 of (do shell script idBin)
		set parentOwnerCommand to ownerBin & " " & myUid & " " & quoted form of theParentPath
		set parentPermsCommand to permsBin & " " & permsParams & " " & quoted form of theParentPath
		set flagsCommand to flagsBin & " " & flagsParams & " " & quoted form of theTargetPath
		set commandSequence to newline & parentOwnerCommand & newline & parentPermsCommand & newline & flagsCommand
		do shell script "echo " & quoted form of commandSequence & " >> " & tmpfile
		
	on error errText number errNum
		if (errNum is equal to -128) then -- User cancelled.
			display dialog "You canceled the operation." buttons "Goodbye" default button 1
		else
			display dialog "Sorry, an error occurred: " & errText & " (" & errNum & ")"
		end if
	end try
end fixItem

on getParent(thePath)
	set AppleScript's text item delimiters to ":"
	if (thePath contains ":") then
		if the last character of thePath is ":" then
			set folderPath to (text items 1 thru -3 of thePath)
		else
			set folderPath to (text items 1 thru -2 of thePath)
		end if
		
		return ((folderPath as string) & ":") as alias
	else
		return thePath
	end if
end getParent

on prepTemp()
	do shell script "echo '' > " & tmpfile
	do shell script permsBin & " +x " & tmpfile
end prepTemp

on runTemp()
	do shell script tmpfile with administrator privileges
	--do shell script rmBin & " " & tmpfile
end runTemp