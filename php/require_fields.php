<?php

////////////////////////////////////////////////////////////
//   RequireFields 0.7
//   a pair of functions for form validation
//
//   Paul Schreiber
//   misc at paulschreiber.com
//   http://paulschreiber.com/
//
//   2005-07-04: Licensed under CreativeCommons-Attribution License
//   http://creativecommons.org/licenses/by/2.5/
//   - added </option> tag and fixed SELECTED. Should be valid XHTML now
//
//   0.5 -- initial release
//   0.6 -- added alpha validation (letters only, no numbers)
//   0.6.1 -- changed include() to require_once(); fixed alpha so it works
//
//   2005-11-26:
//   0.7 -- stricter checking on Canadian postal codes
//
//   types of fields validated
//   -------------------------
//   alpha
//   text
//   dollar amounts
//   numbers
//   IP addresses
//   dates (ISO)
//   times
//   URLs
//   phone numbers
//   email addresses*
//   credit cards*
//   zip and postal codes
//
//   * requires the email.php and creditcard.php modules
//
//   you can also use popup, checkbox and radio; they
//   behave similar to text fields, but the error message
//   has been reworded
//
//   sample code
//   -----------
//   if ( requireFields ($errors, $myHash) ) {
//       requireError ($errors, $myHash);
//   } else {
//       echo "thanks for submitting!<p>\n";
//   }
//
//   sample require hash
//   -------------------
//   $myHash = array (
//        "name" => array("text", "full name"),
//        "workp" => array("phone", "work phone number", 1),
//        "email" => array("email", "email address")
//      );
//
//   require hash structure
//   ----------------------
//   this is a hash, where the key is a field name,
//   and the value is an array. details:
//
//   name => array( type, description, optional)
//
//   name: the form field name, i.e. PHP global variable name
//
//   type: the field type, as defined below
//
//   description: an english description of the field
//
//   optional: placing a 1 here will mark the field as optional;
//             it will be validated only if present
//
//  stylesheets
//  -----------
//  if you define a style .result, the error list will take on
//  its properties
//
//

if ( !defined('REQUIRE_FIELDS_DEFINED') ) {
	define('REQUIRE_FIELDS_DEFINED', TRUE);

	function requireFields (&$errorHash, $requireHash) {

		// loop through the hash and make sure each is valid
		while ( list($fieldName, $fieldInfo) = each ($requireHash) ) {

			// grab the value of the field so we can evaluate it
			global $$fieldName;
			
			// get the type and ignore the description
			$fieldType = $fieldInfo[0];
			
			// we can give a third parameter making the field optional
			if ( sizeof($fieldInfo) > 2) {
				$fieldOptional = $fieldInfo[2];
			} else {
				$fieldOptional = 0;
			}

			// skip nontext fields that are blank AND optional
			if ($fieldType == "text" || (!($fieldOptional && !$$fieldName))) {
				switch ($fieldType) {
					case "text":
					case "popup":
					case "radio":
					case "checkbox":
						if ($$fieldName == "") {
							$errorHash[$fieldName] = 1;
							$errors = 1;
						}
						break;

					case "dollar":
						if (!ereg('^\$([1-9][0-9]*|0)(\.[0-9]{2})?$', $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "alpha":
						if (!ereg("^[A-Za-z]+$", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "number":
						if (!ereg("^-?[1-9][0-9]*(\.[0-9]+)?$", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "ip":
						if (!ereg("([1-2]?[0-9]?[0-9])\.([1-2]?[0-9]?[0-9])\.([1-2]?[0-9]?[0-9])\.([1-2]?[0-9]?[0-9])", $$fieldName, $regs)) {					
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						
						for ($i = 1; (!$errorHash[$fieldName] && $i <= 4); $i++) {
							if ($regs[$i] > 255) {
								$errors = 1;
								$errorHash[$fieldName] = 1;
							}
						}

						break;

					case "date":
						if (!ereg("[0-9]{4}-[01][0-9]-[0-3][0-9]", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}

						if ( ($regs[1] > 12) || ($regs[2] > 31) || ($regs[1] == 2 && $regs[2] > 29) ) {
							$error = 1;
						}
						break;

					case "time":
						if (!ereg("[0-9]{1,3}:[0-5][0-9]:[0-5][0-9]$", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "url":
						if (!ereg("^http://|https://|ftp://", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "phone":
						if (!ereg("^[2-9][0-9]{2}-[2-9][0-9]{2}-[0-9]{4}$", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "zip":
						if (!ereg("^[0-9]{5}(-[0-9]{4})?|[ABCEGHJ-NPRSTVXY][0-9][ABCEGHJ-NPRSTV-Z] [0-9][ABCEGHJ-NPRSTV-Z][0-9]$", $$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "email":
						require_once ("email.php");
						if (!validateEmail($$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

					case "creditcard":
						require_once ("creditcard.php");
						if (!validateCC($$fieldName)) {
							$errorHash[$fieldName] = 1;
							$errors = 1;					
						}
						break;

				} //switch
			} //if
		} // while

		return $errors;
	}
}


if ( !defined('REQUIRE_FIELDS_ERROR_DEFINED') ) {
	define('REQUIRE_FIELDS_ERROR_DEFINED', TRUE);

	function requireError ($errorHash, $requireHash) {

		// don't do anything if there are no errors
		if ( is_array ($errorHash) ) {

			// start the list
			echo "\n\n<ul class=\"result\">\n";

			// go through each field that had a problem
			while ( list($key, $val) = each($errorHash) ) {

				// get the field's type
				$fieldType = $requireHash[$key][0];
				
				// print the appropriate error message
				switch ($fieldType) {
					case "text":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is filled in.\n";
						break;

					case "popup":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is selected.\n";
						break;

					case "radio":
					case "checkbox":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is checked.\n";
						break;

					case "dollar":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid dollar amount ($XXX.XX).\n";
						break;

					case "alpha":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " contains only letters.\n";
						break;

					case "number":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid number.\n";
						break;

					case "ip":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid IP address.\n";
						break;

					case "date":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid date (YYYY-MM-DD).\n";
						break;

					case "time":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid time (HH:MM:SS).\n";
						break;

					case "phone":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid phone number (XXX-XXX-XXXX).\n";
						break;

					case "zip":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid zip or postal code (XXXXX, XXXXX-XXXX or A1A 1A1).\n";
						break;

					case "email":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid email address (sample@foo.com).\n";
						break;

					case "creditcard":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid credit card number.\n";
						break;

					case "url":
						echo "<li>Please ensure the " . $requireHash[$key][1] . " is a valid URL.\n";
						break;

				} //switch
			}
			
			// end the list
			echo "</ul>\n";
		}
		
	} // is_array
}

?>
