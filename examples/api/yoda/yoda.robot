*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://api.funtranslations.com/translate/yoda.json
${API_KEY}    your_api_key_here

*** Test Cases ***
Translate a simple sentence
	[Tags]    positive
	Create Session    yoda    ${BASE_URL}	verify=true
	${data}=    Create Dictionary    text=Hello world
	${headers}=    Create Dictionary    X-Funtranslations-Api-Secret=${API_KEY}
	${response}=    POST On Session    yoda    /    json=${data}    headers=${headers}
	Should Be Equal As Strings    ${response.status_code}    200
	${content}=    Set Variable    ${response.json()}
	Should Be Equal As Strings    ${content["contents"]["translated"]}    Force be with you world

Translate a complex sentence
	[Tags]    positive
	Create Session    yoda    ${BASE_URL}	verify=true
	${data}=    Create Dictionary    text=I am going to the cinema with my friends
	${headers}=    Create Dictionary    X-Funtranslations-Api-Secret=${API_KEY}
	${response}=    POST On Session    yoda    /    json=${data}    headers=${headers}
	Should Be Equal As Strings    ${response.status_code}    200
	${content}=    Set Variable    ${response.json()}
	Should Be Equal    ${content["contents"]["translated"]}     Going to the cinema with my friends, ${SPACE}I am

Translate an empty sentence
	[Tags]     negative
	Create Session     yoda     ${BASE_URL}
	${data}=     Create Dictionary     text=
	${headers}=     Create Dictionary     X-Funtranslations-Api-Secret=${API_KEY}
	${response}=     Post Request     yoda     /     data=${data}     headers=${headers}
	Should Be Equal As Strings     ${response.status_code}     400
	${content}=     Set Variable     ${response.json()}
	Should Be Equal As Strings     ${content.error.message}     Invalid request: Input is required

Translate a sentence with invalid characters
	[Tags]     negative
	Create Session     yoda     ${BASE_URL}
	${data}=     Create Dictionary     text=@#$%^&*
	${headers}=     Create Dictionary     X-Funtranslations-Api-Secret=${API_KEY}
	${response}=     Post Request     yoda     /     data=${data}     headers=${headers}
	Should Be Equal As Strings     ${response.status_code}     400
	${content}=     Set Variable     ${response.json()}
	Should Be Equal As Strings      ${content.error.message}      Invalid request: Input contains invalid characters

#Translate a sentence that exceeds the rate limit
#	[Tags]      negative
#	Create Session      yoda      ${BASE_URL}
#	FOR      ${i}      IN RANGE      6
#		${data}=      Create Dictionary      text=Hello world
#		${headers}=      Create Dictionary      X-Funtranslations-Api-Secret=${API_KEY}
#		Post Request      yoda      /      data=${data}      headers=${headers}
#	END

#Log Many      Too many requests sent. The next request should fail.
#	${data}=      Create Dictionary      text=Hello world
#	${headers}=      Create Dictionary      X-Funtranslations-Api-Secret=${API_KEY}
#	${response}=      Post Request      yoda      /      data=${data}      headers=${headers}
#	Should Be Equal As Strings      ${response.status_code}      429
#	${content}=      Set Variable      ${response.json()}
#	Should Be Equal As Strings       ${content.error.message}       Too Many Requests: Rate limit of 5 requests per hour exceeded. Please wait for 59 minutes and 59 seconds.


