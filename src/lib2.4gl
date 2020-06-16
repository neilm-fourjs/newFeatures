
IMPORT util
IMPORT FGL lib
IMPORT JAVA java.util.regex.Pattern
IMPORT JAVA java.util.regex.Matcher

PUBLIC TYPE t_myLib1 RECORD
		opt1 BOOLEAN
	END RECORD

CONSTANT VER=1.0
CONSTANT AUTH="Neil J Martin"

--------------------------------------------------------------------------------------------------------------
FUNCTION (this t_myLib1) initModule(l_options STRING)
	LET this.opt1 = FALSE
	IF l_options IS NOT NULL THEN
		CALL util.JSON.parse( l_options, this )
	END IF
	DISPLAY "Lib2 Opt1: ",IIF( this.opt1, "TRUE", "FALSE" )
	CALL registerModule(__FILE__, AUTH ,VER )
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION myRegEx( l_ex STRING, l_str STRING ) RETURNS BOOLEAN
  DEFINE p Pattern
  DEFINE m Matcher
  LET p = Pattern.compile(l_ex)
  DISPLAY p.pattern()
  LET m = p.matcher(l_str)
  IF m.matches() THEN
    DISPLAY SFMT("The string '%1' matches the pattern '%2' ...", l_str, l_ex )
		RETURN FALSE
  ELSE
    DISPLAY SFMT("The string '%1' does not matche the pattern '%2' ...", l_str, l_ex )
		RETURN TRUE
  END IF
END FUNCTION