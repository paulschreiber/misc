(*
  Audio from MP4
  by Paul Schreiber
  http://paulschreiber.com/
  paul@paulschreiber.com

  requires macOS. tested on 10.15.6, but should work on earlier versions.

  26 JUly 2020 -- 1.0
   -- initial release
*)

tell current application
	set theResponse to display dialog "Enter the URL" default answer "" with icon note buttons {"Continue"} default button "Continue"
	set theURL to text returned of result

	set t to (time of (current date))
	set filename to "~/webinar-" & t & ".mp4"
	set newfilename to "~/webinar-" & t & ".m4a"

	set curlCommand to "curl -o  " & filename & " " & theURL
	do shell script curlCommand

	set convertCommand to "/usr/bin/avconvert --quiet --preset PresetAppleM4A --source " & filename & " --output " & newfilename

	do shell script convertCommand
	display dialog "Conversion complete!" buttons {"OK"} default button "OK"
end tell
