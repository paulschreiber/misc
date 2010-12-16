<?php

////////////////////////////////////////////////////////////
//   StateList 0.5.2
//   make a popup list of states
//
//   Paul Schreiber
//   msic at paulschreiber.com
//   http://paulschreiber.com/
//
//   0.5.1 -- 12 March 2000
//         -- fixed spelling of Tennessee
//   0.5.2 -- 04 July 2005
//         -- change include() to require_once()
//
//   2005-07-04: Licensed under CreativeCommons-Attribution License
//   http://creativecommons.org/licenses/by/2.5/
//
//   parameters
//   ----------
//
//   popup_name: the name attribute you want for the <SELECT> tag
//
//   javascript: javascript for the <SELECT> tag, i.e.
//               onChange="this.form.submit()" [optional]
//
//   sets: what states and provinces should be included. this works
//         like the unix chmod command. [optional]
//
//   Add up these numbers:
//
//     0 = include US states and Canadian provinces -- special default case
//     1 = include US states
//     2 = include US military "states"
//     4 = include US possessions
//     8 = include Canadian provinces
//
//   So, to include US states and US possessions only, you would do this:
//         stateList("state","",5);
//
//   To include Canadian provinces and US military "states," you would to this
//         stateList("state","",10);
//
//
//


if ( !defined('STATE_LIST_DEFINED') ) {
	define('STATE_LIST_DEFINED', TRUE);

	function stateList ($popup_name, $javascript="", $sets = 0) {

		$us_states = array (
							  "AL" => "Alabama",
							  "AK" => "Alaska",
							  "AZ" => "Arizona",
							  "AR" => "Arkansas",
							  "CA" => "California",
							  "CO" => "Colorado",
							  "CT" => "Connecticut",
							  "DE" => "Delaware",
							  "DC" => "District of Columbia",
							  "FL" => "Florida",
							  "GA" => "Georgia",
							  "HI" => "Hawaii",
							  "ID" => "Idaho",
							  "IL" => "Illinois",
							  "IN" => "Indiana",
							  "IA" => "Iowa",
							  "KS" => "Kansas",
							  "KY" => "Kentucky",
							  "LA" => "Louisiana",
							  "ME" => "Maine",
							  "MD" => "Maryland",
							  "MA" => "Massachusetts",
							  "MI" => "Michigan",
							  "MN" => "Minnesota",
							  "MS" => "Mississippi",
							  "MO" => "Missouri",
							  "MT" => "Montana",
							  "NE" => "Nebraska",
							  "NV" => "Nevada",
							  "NH" => "New Hampshire",
							  "NJ" => "New Jersey",
							  "NM" => "New Mexico",
							  "NY" => "New York",
							  "NC" => "North Carolina",
							  "ND" => "North Dakota",
							  "OH" => "Ohio",
							  "OK" => "Oklahoma",
							  "OR" => "Oregon",
							  "PA" => "Pennsylvania",
							  "RI" => "Rhode Island",
							  "SC" => "South Carolina",
							  "SD" => "South Dakota",
							  "TN" => "Tennessee",
							  "TX" => "Texas",
							  "UT" => "Utah",
							  "VT" => "Vermont",
							  "VA" => "Virginia",
							  "WA" => "Washington",
							  "WV" => "West Virginia",
							  "WI" => "Wisconsin",
							  "WY" => "Wyoming"	
			);

		$canadian_provinces = array (
							  "AB" => "Alberta",
							  "BC" => "British Columbia",
							  "MB" => "Manitoba",
							  "NF" => "Newfoundland",
							  "NB" => "New Brunswick",
							  "NS" => "Nova Scotia",
							  "NT" => "Northwest Territories",
							  "ON" => "Ontario",
							  "PE" => "Prince Edward Island",
							  "QC" => "Quebec",
							  "SK" => "Saskatchewan",
							  "YT" => "Yukon Territory"
			);		

		$us_military = array (
								"AA" => "Armed Forces Americas (except Canada)",
								"AE" => "Armed Forces Africa",
								"AE" => "Armed Forces Canada",
								"AE" => "Armed Forces Europe",
								"AE" => "Armed Forces Middle East",
								"AP" => "Armed Forces Pacific"
			);

		$us_possessions = array (
								"AS" => "American Samoa",
								"FM" => "Federated States Of Micronesia",
								"GU" => "Guam ",
								"MH" => "Marshall Islands",
								"MP" => "Northern Mariana Islands",
								"PW" => "Palau",
								"PR" => "Puerto Rico",
								"VI" => "Virgin Islands"
			);


		//
		// special default case -- North America only
		//
		if ($sets == 0) {
			$state_list = $us_states + $canadian_provinces;

		//
		// figure out what's going on, and generate the appropriate hash
		//
		} else {
		
			// must declare a blank array
			$state_list = array ();
		
			if ($sets >= 8) {
				$sets -= 8;
				$state_list += $canadian_provinces;
			}

			if ($sets >= 4) {
				$sets -= 4;
				$state_list += $us_possessions;
			}

			if ($sets >= 2) {
				$sets -= 2;
				$state_list += $us_military;
			}

			if ($sets >= 1) {
				$sets -= 1;
				$state_list += $us_states;
			}
		}
		
		//
		// we need popup_menu to generate the actual menu
		//
		require_once("popup_menu.php");
		popup_menu($popup_name, $state_list, $javascript);

	}

}
?>
