*** Settings ***
Resource  ../Resource/PO/LandingPage.robot
Resource  ../Resource/PO/TopNavSection.robot
Resource  ../Resource/PO/SearchResult.robot

*** Variables ***
${ELEMENT_LOCATION2} =  //*[@class='s-item__wrapper clearfix']


*** Keywords ***
Load Page
    [Arguments]    ${URL2}
    LandingPage.Load    ${URL2}
    LandingPage.Verify EbayPage Loaded
    ${WINDOWS_TITLE}=  get window titles

Search for Products Ebay
    [Arguments]    ${SEARCH_TERM}
    wait until page contains    ebay
    TopNavSection.EbaySearch for Products   ${SEARCH_TERM}
    SearchResult.Verify EbaySearch Completed    ${SEARCH_TERM}

Retrieve Ebay Product Details
    [Tags]    Ebay Web INfo Gather
     ${Index}    get element count    Xpath=${ELEMENT_LOCATION2}        # get total rec of searched prouct

    FOR  ${Index}  IN RANGE  1  ${Index}+1
        #   TO Retrieve the PRoduct NAme
        ${TMP_LOCATION} =  set Variable  //*[@data-view='mi:1686|iid:${Index}']//*[@class='s-item__title']
        ${present}=  Run Keyword And Return Status    Element Should Be Visible   Xpath=${TMP_LOCATION}
        Run Keyword If  ${present} == True  Retrieve Ebay Product Name  ${TMP_LOCATION}
        ...  ELSE  Initial Ebay Product Name

        #   TO Retrieve the PRoduct Prices
        ${TMP_LOCATION} =  set Variable  //*[@data-view='mi:1686|iid:${Index}']//*[@class='s-item__price']
        ${present}=  Run Keyword And Return Status  Element Should Be Visible   Xpath=${TMP_LOCATION}
        Run Keyword If  ${present} == True  Retrieve Ebay Product Prices  ${TMP_LOCATION}
        ...  ELSE  Initial Ebay Product Price

        #   TO Retrieve the PRoduct Link
        ${TMP_LOCATION} =  set Variable  //*[@data-view='mi:1686|iid:${Index}']//*[@class='s-item__title']
        ${present}=  Run Keyword And Return Status  Element Should Be Visible   Xpath=${TMP_LOCATION}   attribute=href
        Run Keyword If  ${present} == True  Retrieve Ebay Product Link  ${TMP_LOCATION}
        ...  ELSE  Initial Ebay Product Link

        ${COMBINE_INFO} =  Catenate    SEPARATOR=;   ${PRICES}  ${WINDOWS_TITLE}  ${PRODUCTS_NAME}  ${PRICES}  ${HREF_LINKS}
        append to list    ${MASTER_LIST}    ${COMBINE_INFO}
    END

Retrieve Ebay Product Name
    [Arguments]    ${Ele_Addr}
    ${PRODUCTS_NAME} =  get text    Xpath=${Ele_Addr}
    set global variable  ${PRODUCTS_NAME}

Retrieve Ebay Product Prices
    [Arguments]    ${Ele_Addr}
    ${PRICES} =  get text    Xpath=${Ele_Addr}
    set global variable  ${PRICES}

Retrieve Ebay Product Link
    [Arguments]    ${Ele_Addr}
    ${HREF_LINKS} =  get element attribute    Xpath=${Ele_Addr}     attribute=href
    set global variable  ${HREF_LINKS}

Initial Ebay Product Name
    set global variable    ${PRODUCTS_NAME}   '- NO Product Name FOund -'
    [return]    ${PRODUCTS_NAME}

Initial Ebay Product Link
    set global variable    ${HREF_LINKS}   '- NO Link Found -'
    [return]    ${HREF_LINKS}

Initial Ebay Product Price
    set global variable    ${PRICES}  0.00
    [return]    ${PRICES}