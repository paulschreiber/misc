<?php

////////////////////////////////////////////////////////////
//   TableToHash 0.5.2
//   turn a MySQL database table into a hash, and optionally
//   a state-maintaining popup menu (<SELECT> box)
//
//   Paul Schreiber
//   misc at paulschreiber.com
//   http://paulschreiber.com/
//
//   0.5   -- initial release
//   0.5.1 -- fixed a bug in the docs 8 December 1999
//   0.5.2 -- changed require() to require_once()
//
//   2005-07-04: Licensed under CreativeCommons-Attribution License
//   http://creativecommons.org/licenses/by/2.5/
//   
//   there are two complementary functions here:
//      tableToHash, which returns a hash
//      tableToPopup, which prints out a popup menu based on the hash
//
//   IMPORTANT: you must have already opened a connection to
//              a MySQL database before using this, otherwise
//              mysql_query() will fail
//
//
//   parameters
//   ----------
//   table: the database table name
//
//   id: the unique key for the table
//
//   values: the value (or values) that correspond to each key
//	         you can supply either a scalar (column name) or an
//           array of column name
//
//   where: an optional WHERE clause, restricting which items to select
//
//   order: an optional ORDER BV clauses, sorting the results from the db
//
//   concatChar: the character which joins multiple columns in the values
//               of the hash
//
//   sample code
//   -----------
//   $members = tableToHash ( "people", "people_id",
//                            array( "fname", "lname"),
//                            "", // leave where blank
//                            "lname" );
//
//
//   tableToPopup ( "books", "book_id", "book_title", "", "book_author" );
//
//
//
//



if ( !defined('TABLE_POPUP_DEFINED') ) {
	define('TABLE_POPUP_DEFINED', TRUE);

	function tableToHash ($table, $id, $values, $where = "", $order = "", $concatChar = " ") {
		
		// check the required parameters
		if (! ($table && $id && $values) ) {
				echo "[parameter error]";
				return ( array() );	
		}
		
		// if we are selecting multiple columns (i.e. have been passed an array)
		// then join the array items together in a list
		if ( is_array($values) ) {
			$valueList = join (", ", $values);
		} else {
			$valueList = $values;
		}

		// the minimal select statement
		$sql = "SELECT $id, $valueList FROM $table";

		// add a where statement, if the user supplied one
		if ($where)
			$sql .= " WHERE $where";

		// add a order by statement, if the user supplied one
		if ($order)
			$sql .= " ORDER BY $order";

		// execute the query
		// quiet mode, keep the output nice
		$result = @mysql_query($sql);
		
		if ($result) {
			$rows = mysql_num_rows($result);

			// the database returned at least one row,
			// so loop through the result
			if ($rows) {
			
				// we are selecting multiple columns, so we will concatenate
				// them together for the values of the hash
				if ( is_array($values) ) {
					while ( $myrow = mysql_fetch_array($result) ) {

						$temp = "";
						while ( list($key, $val) = each($values) ) {
							$temp .= $myrow[$val] . $concatChar;
						}
						
						// get rid of the extra space at the end
						$temp = chop ($temp);
						$hash[ $myrow[$id] ] = $temp;
						reset ($values);
					}
				
				// we are selecting only one column
				} else {
					while ( $myrow = mysql_fetch_array($result) ) {
						$hash[ $myrow[$id] ] = $myrow[$values];
					}
				}

				// success!
				return $hash;

			} else {
				echo "[no $table available]";
				return ( array() );
			}

		} else {
			echo "[database error]";
			return ( array() );
		}
	}

	function tableToPopup ($table, $id, $values, $where = "", $order = "") {
		require_once("popup_menu.php");
		popup_menu ($id, tableToHash ($table, $id, $values, $where, $order) );
	}

}
?>
