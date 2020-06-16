
-- Import some Genero library modules
IMPORT FGL lib
IMPORT FGL lib2

-- include a type definition
&include "types.inc"

-- define a constant value
CONSTANT VER=1.0
CONSTANT AUTH="Neil J Martin"

-- setup variables for the library module version information
DEFINE m_lib lib.t_myRec
DEFINE m_lib2 lib2.t_myLib1

MAIN
-- an example of a dynamic array and of variable initialization in the define.
	DEFINE l_nums DYNAMIC ARRAY OF DECIMAL(12,2) = [ 9.95, 8.50, 12.98 ]
	DEFINE l_myCallBackFunc FUNCTION()
	DEFINE x SMALLINT

-- setup this modules version info
	CALL lib.registerModule(__FILE__,AUTH,VER)
	CALL m_lib.initModule() -- Initialize the library.
	CALL m_lib2.initModule('{ "opt1": 1}') -- Initialize the library using a JSON string
	CALL lib.showModules() -- Show the modules and the versions used.
-- simple string demo
	CALL lib.sayHello( l_whom: "Neil" )

-- Add some more number to the array
	LET x = l_nums.getLength()
	LET l_nums[ x := x + 1 ] = 4.99
	LET l_nums[ x := x + 1 ] = 7.65
-- call a function passing a dynamic array
	CALL lib.showValues(l_nums)

-- call a function passing a dynamic array and directly display it's returning value
	DISPLAY "Total is "||lib.calcTotal( l_nums )
-- call a function passing a dynamic array, highlight that it's passed as a reference.
	CALL lib.addTax( l_nums, l_tax: 17.5 )
	DISPLAY "New Total is "||lib.calcTotal( l_nums )

-- Java bridge: see if the string matches the pattern
	IF lib2.myRegEx( l_ex: "[a-z][0-9]", l_str: "a5") THEN
	-- Do something
	END IF
	IF lib2.myRegEx("[a-z][0-9]","A5") THEN -- this one should fail
	-- Do something
	END IF

-- setup a callback function
	LET l_myCallBackFunc = FUNCTION myCallBack
-- pass our callback function to the library, so the library can call it.
	CALL lib.callMyFunction( l_myCallBackFunc )

END MAIN
--------------------------------------------------------------------------------------------------------------
FUNCTION myCallBack() RETURNS ()
	DISPLAY "in the callback function in main.4gl"
END FUNCTION