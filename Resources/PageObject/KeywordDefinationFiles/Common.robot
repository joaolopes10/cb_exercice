*** Settings ***
Library           SeleniumLibrary
Variables         ../Locators/locators.py
Variables         ../TestData/users.py
Library           Dialogs
Resource          cart.robot

*** Variables ***
${timeout}        30s

*** Keywords ***
Open Application
    [Documentation]    This Keyword Opens the app URL on the defined browser
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${url} | App URL |
    ...    | ${browser} | Browser to be launched |
    ...
    ...
    ...
    ...    *Examples: *
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window

Login and return to homepage
    [Arguments]    ${user}
    [Documentation]    This Keyword Performes the Login and returns to the HomePage
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${user} | User Dictionary that contains the user info |
    ...
    ...
    ...    *Examples: *
    ...    - Login and return to homepage	${testuser}
    I click on the button with the title "Log in to your customer account"
    Wait Until Element Is Visible    ${username}    timeout=${timeout}
    Input Text    ${username}    ${user['username']}
    Input Text    ${password}    ${user['password']}
    Click Button    ${signin}
    Wait Until Page Contains    Welcome to your account. Here you can manage all of your personal information and orders.    timeout=${timeout}
    Click Element    ${homebutton}
    Wait Until Page Contains    Automation Practice Website

I click on the button with the title "${text}"
    [Documentation]    This Keyword clicks on an element with an matching title
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${text} | Element title \ |
    ...
    ...
    ...    *Examples: *
    ...
    ...    - I click on the button with the title "View my shopping cart"
    ${text}    Set Variable If    "${text}"!="${EMPTY}"    ${text.lower()}
    ${element}    Replace Variables    ${button_with_text}
    I wait and click on the "${element}" element

I wait and click on the "${element}" element
    [Documentation]    This Keyword waits for page contains an element then clicks on It
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${element} | Locator to click on |
    ...
    ...    *Examples: *
    ...
    ...    - I wait and click on the "${login}" element
    Wait Until Element Is Visible    ${element}
    Scroll Element Into View    ${element}
    Click Element    ${element}
