*** Settings ***
Documentation  Amazon top navigation
Library  SeleniumLibrary


*** Keywords ***
Search for Products
    [Arguments]    ${SEARCH_TERM}
    Enter Search Term   ${SEARCH_TERM}

Enter Search Term
    [Arguments]    ${SEARCH_TERM}
    Input Text  id=twotabsearchtextbox  ${SEARCH_TERM}
    press keys  id=twotabsearchtextbox  ENTER

Submit Search
    Click Button  xpath=//*[@id="nav-search-submit-text"]/input

EbaySearch for Products
    [Arguments]    ${SEARCH_TERM}
    EbayEnter Search Term   ${SEARCH_TERM}

EbayEnter Search Term
    [Arguments]    ${SEARCH_TERM}
    Input Text  id=gh-ac  ${SEARCH_TERM}
    press keys  id=gh-btn  ENTER

