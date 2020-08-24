*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Verify Page Loaded
    [Documentation]    Verify the search result
    Wait Until Page Contains  Back to results


Verify Search Completed
    [Documentation]    verify the search result
    [Arguments]    ${SEARCH_TERM}
    wait until page contains    results for "${SEARCH_TERM}"
    wait until page contains    Need help?

Verify EbayPage Loaded
    [Documentation]    Verify the search result
    Wait Until Page Contains  Back to results


Verify EbaySearch Completed
    [Documentation]    verify the search result
    [Arguments]    ${SEARCH_TERM}
    sleep  3s
    wait until page contains    "${SEARCH_TERM}"
