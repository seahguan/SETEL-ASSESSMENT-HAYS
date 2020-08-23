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
    FOR  ${Index}  IN RANGE  1  ${CNT}
        ${Single}=  set variable    ${List_String}[${Index}]
        @{Word}=   Split String    ${Single}     ;
#        Write Each Product Info     @{Word}
        ${Index2}=  set variable    1
        FOR  ${i}  IN RANGE  2  5
            ${Index2}  Evaluate   ${Index2}+1

            Run Keyword If  ${Index2} == 2   Write Web Name  ${word}${i}
            ...  ELSE If  ${Index2} == 3   Write Product Name  ${word}${i}
            ...  ELSE If  ${Index2} == 4   Write Price  ${word}${i}
            ...  ELSE If  ${Index2} == 5   Write Product Link  ${word}${i}

#        END
    END


*** Keywords ***
Write Web Name
    [Arguments]    ${wording}
    ${OutputString}=  Catenate  'Web Title : '  ${wording}
    log  ${OutputString}

Write Product Name
    [Arguments]    ${wording}
    ${OutputString}=  Catenate  'Product Name : '  ${wording}
    log  ${OutputString}

Write Web Price
    [Arguments]    ${wording}
    ${OutputString}=  Catenate  'Prices : '  ${wording}
    log  ${OutputString}

Write Product Link
    [Arguments]    ${wording}
    ${OutputString}=  Catenate  'Product Link : '  ${wording}
    log  ${OutputString}

Write Each Product Info
    [Arguments]    ${word}
    ${Index2}=  set variable    0
    FOR  ${i}  IN RANGE  1  5
        ${Index2}  Evaluate   ${Index2}+1

        Run Keyword If  ${Index2} ==  2  Write Web Name  ${word}${i}
        ...  ELSE If  ${Index2} ==  3  Write Product Name  ${word}${i}
        ...  ELSE If  ${Index2} ==  4  Write Price  ${word}${i}
        ...  ELSE If  ${Index2} ==  5  Write Product Link  ${word}${i}

    END