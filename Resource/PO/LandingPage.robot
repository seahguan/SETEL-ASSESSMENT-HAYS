*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Load
    [Arguments]    ${URL}
    Go To  ${URL}

Verify Page Loaded
    Wait Until Page Contains  Hello

Verify EbayPage Loaded
    Wait Until Page Contains  Hi

