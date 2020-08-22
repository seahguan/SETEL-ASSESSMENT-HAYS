*** Settings ***
Documentation    initial script basic requirement
Resource  ../Resource/Common.robot  # for Setup & Teardown
Resource  ../Resource/Amazon.robot
#Resource  ../Resource/Ebay.robot
Library    string
Library    SeleniumLibrary
Library    Collections

Test Setup  Common.Begin Web Test   ${BROWSER}
Test Teardown  Common.End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://www.amazon.com
${URL2} =  https://www.ebay.com
${SEARCH_TERM} =  Iphone 11
@{MASTER_LIST}



*** Test Cases ***
GET search product details all
    Amazon.Load Page    ${URL}
    ${Browser_Title} =  get title
    Amazon.Search for Products  ${SEARCH_TERM}
    Amazon.Retrieve Product Details

    FOR  ${Index}  IN RANGE  0  10
        Log  ${MASTER_LIST}[${Index}]
        # TODO slice the string and write into report
    END

#   Amazon.Merge info
#   Amazon.sort the @{products_name}
    # log into report
#    SortValue   ${1234}
#    open browser    ${BROWSER}
#    Ebay.LoadPage   ${URL2}

#    Amazon.Retrieve Product Details

*** Keywords ***
