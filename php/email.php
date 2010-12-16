<?php

//   Paul Schreiber
//   misc at paulschreiber.com
//   http://paulschreiber.com/
//
//   2005-07-04: Licensed under CreativeCommons-Attribution License
//   http://creativecommons.org/licenses/by/2.5/
//   - updated so TLDs of up to 6 letters (.museum) are valid
//

if ( !defined('VALIDATE_EMAIL_DEFINED') ) {
	define('VALIDATE_EMAIL_DEFINED', 1);

	function validateEmail ($address) {
		return (!
				( ereg("(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)", $address) ||
			     !ereg("^.+\@(\[?)[a-zA-Z0-9\.\-]+\.([a-zA-Z]{2,6}|[0-9]{1,3})(\]?)$", $address)
			    )
		);
	}
}
?>
