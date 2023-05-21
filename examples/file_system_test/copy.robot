*** Settings ***
Library    OperatingSystem
Library    filecomparison
Suite Teardown    Remove test artifacts 

*** Variables ***
${SOURCE_FILE}    source.txt
${TARGET_FILE}    target.txt
${SOURCE_DIR}    source
${TARGET_DIR}    target


*** Keyword ***
Remove test artifacts 
	Remove file	${SOURCE_FILE}
	Remove file	${TARGET_FILE}
	Remove directory 	${SOURCE_DIR}	recursive=true
	Remove directory 	${TARGET_DIR}   recursive=true

*** Test Cases ***
Copy a file to another file
	Create File    ${SOURCE_FILE}    Hello world
	Copy File    ${SOURCE_FILE}    ${TARGET_FILE}
	File Should Exist    ${TARGET_FILE}
	Compare Files    ${SOURCE_FILE}    ${TARGET_FILE}

Copy a file to a directory
	Create File    ${SOURCE_FILE}    Hello world
	Create Directory    ${TARGET_DIR}
	Copy File    ${SOURCE_FILE}    ${TARGET_DIR}
	File Should Exist    ${TARGET_DIR}/${SOURCE_FILE}
	Compare Files    ${SOURCE_FILE}    ${TARGET_DIR}/${SOURCE_FILE}

Copy a directory to another directory
	Create Directory    ${SOURCE_DIR}
	Create File    ${SOURCE_DIR}/file1.txt    Hello world
	Create File    ${SOURCE_DIR}/file2.txt    Goodbye world
	Create Directory    ${TARGET_DIR}
	Copy Directory    ${SOURCE_DIR}    ${TARGET_DIR}
	Directory Should Exist    ${TARGET_DIR}/${SOURCE_DIR}
	Compare Directories    ${SOURCE_DIR}    ${TARGET_DIR}/${SOURCE_DIR}


