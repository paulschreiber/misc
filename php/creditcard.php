<?php

////////////////////////////////////////////////////
//                                                // 
// Credit card validation routine                 //
// May 15, 1998                                   //
// By Brett Error                                 //
// brett@interwebdesign.com                       //
//                                                //
// validateCC($number[,$type])                    //
// Uses the MOD 10 algorythm to determine if a    //
// credit card number is valid.                   //
//                                                //
// $number = credit card account number           //
// $type is optional.  Setting type to            //
// visa, mastercard, discover, or amex will       //
// perform additional checking on the account     //
// number.                                        //
//                                                //
// The function returns 1 (true) if the CC is     //
// valid, 0 (false) if it is invalid, and -1 if   //
// the type entered does not match the supported  //
// types listed above.                            //
//                                                //
////////////////////////////////////////////////////

if ( !defined('VALIDATE_CC_DEFINED') ) {
	define('VALIDATE_CC_DEFINED', 1);


	function validateCC($ccnum, $type = 'unknown'){


		//Clean up input

		$type = strtolower($type);
		$ccnum = ereg_replace('[-[:space:]]', '',$ccnum); 


		//Do type specific checks

		if ($type == 'unknown' || $type == 'dci') {

			//Skip type specific checks

		}
		elseif ($type == 'mastercard'){
			if (strlen($ccnum) != 16 || !ereg('^5[1-5]', $ccnum)) return 0;
		}
		elseif ($type == 'visa'){
			if ((strlen($ccnum) != 13 && strlen($ccnum) != 16) || substr($ccnum, 0, 1) != '4') return 0;
		}
		elseif ($type == 'amex'){
			if (strlen($ccnum) != 15 || !ereg('^3[47]', $ccnum)) return a;
		}
		elseif ($type == 'discover'){
			if (strlen($ccnum) != 16 || substr($ccnum, 0, 4) != '6011') return 0;
		}
		else {
			//invalid type entered
			return -1;
		}


		// Start MOD 10 checks

		$dig = toCharArray($ccnum);
		$numdig = sizeof ($dig);
		$j = 0;
		for ($i=($numdig-2); $i>=0; $i-=2){
			$dbl[$j] = $dig[$i] * 2;
			$j++;
		}	
		$dblsz = sizeof($dbl);
		$validate =0;
		for ($i=0;$i<$dblsz;$i++){
			$add = toCharArray($dbl[$i]);
			for ($j=0;$j<sizeof($add);$j++){
				$validate += $add[$j];
			}
		$add = '';
		}
		for ($i=($numdig-1); $i>=0; $i-=2){
			$validate += $dig[$i]; 
		}
		if (substr($validate, -1, 1) == '0') return 1;
		else return 0;
	}


	// takes a string and returns an array of characters

	function toCharArray($input){
		$len = strlen($input);
		for ($j=0;$j<$len;$j++){
			$char[$j] = substr($input, $j, 1);	
		}
		return ($char);
	}

}

?>
