Ruby/Watir data driven testing framework with excel data store.

It is comprised of three major components

1) controller - high level script that schedules driver suite execution
2) driver - low level script that executes the AUT test.
3) lib - common methods and object mapping shared by the test suites.

The controller and driver scripts are isolated from the application.
All access goes through library methods. If any AUT objects or methods 
change, then only a simple library change is required.

AUT url - The ip address (test_site) of the target application is maintained
in the windows host file (C:/WINDOWS/system32/drivers/etc/hosts). The test_site
can be changed by running ..\tools\chng_testsite.rb). 


Version Control -
The git version control system is currently used to manage the framework.

Tags that equal the six digit perforce build number will be used to represent the state
of the repository when a firmware version is released. This snapshot will also be commited
to perforce   
	For example: "IS-WEBCARD_HID6_3.100.3_057437" 
The tag that represents this build is 057437 


lib - The major library components are:
	navigate - web objects: links, buttons, checkboxes, radio buttons, select lists
	setup - test startup methods, login, log and spreadsheet initialization, 
	teardown - test closeout, restore AUT to entry point, close and save logs and spreadsheets
	generic - common methods used by most scripts
	xls - common spreadsheet operation
	telnet - protocol specific interface
	snmp - protocol specific interface
	 




