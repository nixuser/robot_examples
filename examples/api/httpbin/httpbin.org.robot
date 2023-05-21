*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
# ${BASE_URL}    https://httpbin.org
${BASE_URL}    http://localhost:8080

*** Test Cases ***

Get IP Address
	[Documentation]    Test GET /ip endpoint
	Create Session    httpbin    ${BASE_URL}	verify=true
	${response}=    Get On Session    httpbin    /ip
	Status Should Be    200    ${response}
	${ip}=    Get Value From Json    ${response.json()}    origin
	Should Match Regexp    ${ip}[0]    \\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}

Post User Data
	[Documentation]    Test POST /post endpoint with JSON data
	Create Session    httpbin    ${BASE_URL}	verify=true
	&{data}=    Create Dictionary    name=John Doe    email=john.doe@example.com
	${response}=    Post On Session    httpbin    /post    json=${data}
	Status Should Be    200    ${response}
	${name}=    Get Value From Json    ${response.json()}    $..name
	Should Be Equal As Strings    ${name}[0]    John Doe
	${email}=    Get Value From Json    ${response.json()}     json.email
	Should Be Equal As Strings     ${email}[0]     john.doe@example.com

Get Image
	[Documentation]     Test GET /image endpoint with different image formats
	Create Session     httpbin     ${BASE_URL}
	@{formats}=     Create List     jpeg     png     svg     webp
	FOR     ${format}     IN     @{formats}
	${response}=     Get On Session     httpbin     /image/${format}
	Status Should Be     200     ${response}
	Should Contain     ${response.headers['Content-Type']}     image/${format}
	END

Put Data
	[Documentation]      Test PUT /put endpoint with form data
	Create Session      httpbin      ${BASE_URL}
	&{data}=      Create Dictionary      foo=bar      hello=world
	${response}=      Put On Session      httpbin      /put      data=${data}
	Status Should Be      200      ${response}
	${form}=      Get Value From Json      ${response.json()}      $..form
	Dictionaries Should Be Equal   ${data}   ${form}[0]

Delete Data
	[Documentation]       Test DELETE /delete endpoint with query parameters
	Create Session       httpbin       ${BASE_URL}
	&{params}=       Create Dictionary       id=123       name=Bob
	${response}=       Delete On Session       httpbin       /delete       params=&{params}
	Status Should Be       200       ${response}
	@{args}=       Get Value From Json       ${response.json()}       $..args
	Dictionaries Should Be Equal       ${args}[0]       ${params}
