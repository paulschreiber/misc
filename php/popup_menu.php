<?php

////////////////////////////////////////////////////////////
//   PopUpMenu 0.6
//   make a popup menu that maintains its state
//
//   Paul Schreiber
//   misc at paulschreiber.com
//   http://paulschreiber.com/
//
//   2005-11-26:
//   - Escape special characters used in hash, better preserving MVC
//     abstraction
//
//   2005-07-04: Licensed under CreativeCommons-Attribution License
//   http://creativecommons.org/licenses/by/2.5/
//   - added </option> tag and fixed SELECTED. Should be valid XHTML now
//
//   parameters
//   ----------
//
//   name: the name attribute you want for the <SELECT> tag
//
//   values: a hash that contains the values and labels for
//           the <OPTION> tags
//
//   javascript: javascript for the <SELECT> tag, i.e.
//               onChange="this.form.submit()" [optional]
//
//   size: the SIZE attribute for the <SELECT> tag [optional]
//
//
//

if ( !defined('POPUP_MENU_DEFINED') ) {
	define('POPUP_MENU_DEFINED', TRUE);

		function popup_menu ($name, $values, $javascript = "", $size = 1) {

			// grab this to maintain state
			global $$name;
			$selected = ($$name) ? $$name : "";

			// start building the popup meny
			$result = "<select name=\"$name\"";
			
			if ($size != 1)
				$result .= " size=\"$size\"";
				
			if ($javascript)
				$result .= " " . $javascript;
			
			$result .= ">\n";
			
			$result .= "<option value=\"\">\n";
			
			// list all the options
			while ( list( $value, $label ) = each( $values ) ) {
				$value2 = htmlspecialchars($value);
				$label2 = htmlspecialchars($label);
			
				// printed SELECTED if an item was previously selected
				// so we maintain the state
				if ($selected == $value) {
					$result .= "<option value=\"$value2\" selected=\"selected\">$label2</option>\n";
				} else {
					$result .= "<option value=\"$value2\">$label2</option>\n";
				}
			}
			
			// finish the popup menu
			$result .= "</select>\n";
			
			echo $result;
		}

}

?>
