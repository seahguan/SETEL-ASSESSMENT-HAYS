*** Settings ***
Documentation    initial script basic requirement
Resource  ../Resource/Common.robot  # for Setup & Teardown
Resource  ../Resource/Amazon.robot
Resource  ../Resource/Ebay.robot
Library    String
Library    SeleniumLibrary
Library    Collections
Library    BuiltIn


Test Setup  Common.Begin Web Test   ${BROWSER}
Test Teardown  Common.End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =  https://www.amazon.com
${URL2} =  https://www.ebay.com
${SEARCH_TERM} =  Iphone 11
@{MASTER_LIST}
${PRODUCTS_NAME}
${HREF_LINKS}
${PRICES}
${COMBINE_INFO}
${WINDOWS_TITLE}
${sorted_list_asc}
${CNT}


*** Test Cases ***
Browse Iphone 11 on Both Web
    Amazon.Load Page    ${URL}
    Amazon.Search for Products  ${SEARCH_TERM}
    Amazon.Retrieve Product Details
    Ebay.Load Page    ${URL2}
    Ebay.search for products Ebay    ${SEARCH_TERM}
    Ebay.Retrieve Ebay Product Details

    ${sorted_list_asc}=  copy list    ${MASTER_LIST}
    Sort List  ${sorted_list_asc}
    Get Total Count    @{MASTER_LIST}
    Write Result Into Report     @{MASTER_LIST}


*** Keywords ***
Get Total Count
    [Arguments]    @{input}
    ${CNT}=    Get length    ${input}
    set global variable    ${CNT}

Write Result Into Report
    [Arguments]    @{List_String}
    [Tags]    Write into Report
    FOR  ${Index}  IN RANGE  1  ${CNT}
        ${Single}=  set variable    ${List_String}[${Index}]
        ${Single}  replace string    ${Single}  (?<![/\d])\d{1,2}/\d{1,2}/\d{4}(?![/\d])  -

        @{Word}=   Split String    ${Single}     ;
        Write Each Product Info     ${Word}
    END

Write Each Product Info
    [Arguments]    ${wording}
    [Tags]    Output Report
#    ${OutputString}  Replace String Using Regexp  ${wording}  (?<![/\d])\d{1,2}/\d{1,2}/\d{4}(?![/\d])   -
    ${OutputString_Title}=  Catenate  'Web Title : '  ${wording}[1]
    set global variable  ${OutputString_Title}
    ${OutputString_Product}=  Catenate  'Product Name : '  ${wording}[2]
    set global variable  ${OutputString_Product}
    ${OutputString_Price}=  Catenate  'Prices : '  ${wording}[3]
    set global variable  ${OutputString_Price}
    ${OutputString_Link}=  Catenate  'Product Link : '  ${wording}[4]
    set global variable  ${OutputString_Link}
    log  ${OutputString_Title}
    log  ${OutputString_Product}
    log  ${OutputString_Price}
    log  ${OutputString_Link}