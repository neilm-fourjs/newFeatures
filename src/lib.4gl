
IMPORT os

&include "types.inc"

DEFINE m_modules DYNAMIC ARRAY OF t_myRec

CONSTANT VER=1.0
CONSTANT AUTH="Neil J Martin"

--------------------------------------------------------------------------------------------------------------
FUNCTION (this t_myRec) initModule()
	LET this.module = __FILE__
	LET this.version = VER
	LET this.author = AUTH
	CALL registerModule( this.* )
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION registerModule( l_mod STRING, l_auth STRING, l_ver DECIMAL(5,2) )
	CALL m_modules.appendElement()
	LET m_modules[ m_modules.getLength() ].module = os.path.baseName( l_mod )
	LET m_modules[ m_modules.getLength() ].author = l_auth
	LET m_modules[ m_modules.getLength() ].version = l_ver
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION showModules()
	DEFINE x SMALLINT
	FOR x = 1 TO m_modules.getLength()
		DISPLAY SFMT( "Module %1: %2 by %3",m_modules[x].module, (m_modules[x].version USING "&.&&"), m_modules[x].author )
	END FOR
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION sayHello( l_whom STRING )
	DISPLAY SFMT( "Hello %1, your name has %2 letters in it and the 2nd letter is '%3'", 
		l_whom, 
		l_whom.getLength(),
		l_whom.getCharAt(2))
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION calcTotal( l_nums DYNAMIC ARRAY OF DECIMAL(12,2) ) RETURNS DECIMAL(12,2)
	DEFINE x SMALLINT
	DEFINE l_tot DECIMAL(12,2) = 0
	FOR x = 1 TO l_nums.getLength()
		LET l_tot = l_tot + l_nums[ x ]
	END FOR
	RETURN l_tot	
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION showValues( l_nums DYNAMIC ARRAY OF DECIMAL(12,2)) RETURNS ()
	DEFINE x SMALLINT
	FOR x = 1 TO l_nums.getLength()
		DISPLAY l_nums[x]
	END FOR
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION addTax( l_nums DYNAMIC ARRAY OF DECIMAL(12,2), l_tax DECIMAL(12,2)) RETURNS ()
	DEFINE x SMALLINT
	FOR x = 1 TO l_nums.getLength()
		LET l_nums[ x ] = l_nums[x] + ( l_nums[ x ] * ( l_tax / 100 ) )
	END FOR	
END FUNCTION
--------------------------------------------------------------------------------------------------------------
FUNCTION callMyFunction(l_func FUNCTION() )
	DISPLAY "In lib.4gl about to call the passed call back function"
	CALL l_func()
END FUNCTION