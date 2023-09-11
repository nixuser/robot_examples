*** Settings ***
Documentation    Test suite for Open Brewery DB API
Library          RequestsLibrary
Library 	 Collections

*** Test Cases ***
Verify API Endpoint
    Create Session    openbrewerydb    https://api.openbrewerydb.org  verify=true
    ${response}=    Get On Session 	openbrewerydb    /breweries
    Should Be Equal As Strings    ${response.status_code}    200

    # show response content
    # Log To console    ${response.json()[0]}
    # Log To console    ${response.json()[0]['state_province']}

    Dictionary Should Contain Key   ${response.json()[0]}   street
    Should Be Equal As Strings   ${response.json()[0]['state_province']}   Oklahoma
