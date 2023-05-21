*** Settings ***
Library    OperatingSystem

#*** Variables ***
#${CURDIR}    ${CURDIR}
#${HOME}    ${HOME}

*** Test Cases ***
List files in current directory
	[Documentation]    Verify that ls command lists files in the current directory
	${result}=    Run And Return Rc And Output    ls
	Should Be Equal As Integers    ${result[0]}    0
	Should Contain    ${result[1]}    robot.txt

List files in specific directory
	[Documentation]    Verify that ls command lists files in a specific directory
	${result}=    Run And Return Rc And Output    ls ${HOME}
	Should Be Equal As Integers    ${result[0]}    0
	Should Contain    ${result[1]}    Documents

List files with wildcard pattern
	[Documentation]    Verify that ls command lists files with a wildcard pattern
	${result}=    Run And Return Rc And Output    ls *.txt
	Should Be Equal As Integers    ${result[0]}    0
	Should Contain    ${result[1]}    robot.txt


