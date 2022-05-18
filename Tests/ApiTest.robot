*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Variables         ../Resources/PageObject/TestData/api_test.py

*** Variables ***

*** Test Cases ***
GET request to retrieve all Houses names
    [Documentation]    *Description* : Send a GET request to retrieve all “Houses” names for the “Dorne” region
    ...
    ...    *Expected Result*
    ...    - Response status code = 200
    ...    - Validate that the retrieved list of “Houses Names” (from the response) is equal to an expected list
    Create Session    mysession    https://www.anapioficeandfire.com    verify=true
    ${response}=    GET On Session    mysession    /api/houses?    params=region=Dorne
    Status Should Be    200    ${response}    #Check Status as 200
    #Retrieve all houses names to a list and compare it
    ${houses}=    Get Value From Json    ${response.json()}    $..name
    Lists Should Be Equal    ${houses}    ${houses_list}
