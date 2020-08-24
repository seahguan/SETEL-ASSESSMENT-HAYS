*** Settings ***
Library  SeleniumLibrary


*** Variables ***

*** Keywords ***
Begin Web Test
    [Arguments]  ${BROWSER}
    Open Browser  about:blank  ${BROWSER}  # remote_url=${REMOTE_URL}  desired_capabilities=${DESIRED_CAPABILITIES}
    Maximize Browser Window

End Web Test
    Close Browser