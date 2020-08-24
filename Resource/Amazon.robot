*** Settings ***
Resource  ../Resource/PO/LandingPage.robot
Resource  ../Resource/PO/TopNavSection.robot
Resource  ../Resource/PO/SearchResult.robot
Library    Collections


*** Variables ***
${Index} =  0
${ELEMENT_LOCATION} =  //*[@cel_widget_id='MAIN-SEARCH_RESULTS']

*** Keywords ***
Load Page
    [Arguments]    ${URL}
    LandingPage.Load    ${URL}
    LandingPage.Verify Page Loaded
    ${WINDOWS_TITLE}=  get window titles
    set global variable     ${WINDOWS_TITLE}

Search for Products
    [Arguments]    ${SEARCH_TERM}
    wait until page contains    Amazon
    TopNavSection.Search for Products   ${SEARCH_TERM}
    SearchResult.Verify Search Completed    ${SEARCH_TERM}

Retrieve Product Details
    [Tags]    Amazon web info Gather
    ${Index}    get element count    Xpath=${ELEMENT_LOCATION}        # get total rec of searched prouct

    FOR  ${Index}  IN RANGE  2  ${Index}+1
        #   TO Retrieve the PRoduct NAme
        ${TMP_LOCATION} =  set Variable  //*[@data-index=${Index}]//*[@cel_widget_id='MAIN-SEARCH_RESULTS']//*[@class='a-size-medium a-color-base a-text-normal']
        ${present}=  Run Keyword And Return Status    Element Should Be Visible   Xpath=${TMP_LOCATION}
        Run Keyword If  ${present} == True  Retrieve Product Name  ${TMP_LOCATION}
        ...  ELSE  Initial Product Name

        #   TO Retrieve the PRoduct Prices
        ${TMP_LOCATION} =  set Variable  //*[@data-index=${Index}]//*[@cel_widget_id='MAIN-SEARCH_RESULTS']//*[@class='a-price-whole']
        ${present}=  Run Keyword And Return Status  Element Should Be Visible   Xpath=${TMP_LOCATION}
        Run Keyword If  ${present} == True  Retrieve Product Prices  ${TMP_LOCATION}
        ...  ELSE  Initial Product Price

        #   TO Retrieve the PRoduct Link
        ${TMP_LOCATION} =  set Variable  //*[@data-index=${Index}]//*[@cel_widget_id='MAIN-SEARCH_RESULTS']//*[@class='a-link-normal s-no-outline']
        ${present}=  Run Keyword And Return Status  Element Should Be Visible   Xpath=${TMP_LOCATION}   attribute=href
        Run Keyword If  ${present} == True  Retrieve Product Link  ${TMP_LOCATION}
        ...  ELSE  Initial Product Link

        ${COMBINE_INFO} =  Catenate    SEPARATOR=;   ${PRICES}  ${WINDOWS_TITLE}   ${PRODUCTS_NAME}    ${PRICES}   ${HREF_LINKS}
        append to list    ${MASTER_LIST}    ${COMBINE_INFO}
    END


Retrieve Product Name
    [Arguments]    ${Ele_Addr}
    ${PRODUCTS_NAME} =  get text    Xpath=${Ele_Addr}
    set global variable  ${PRODUCTS_NAME}


Retrieve Product Prices
    [Arguments]    ${Ele_Addr}
    ${PRICES} =  get text    Xpath=${Ele_Addr}
    set global variable  ${PRICES}

Retrieve Product Link
    [Arguments]    ${Ele_Addr}
    ${HREF_LINKS} =  get element attribute    Xpath=${Ele_Addr}     attribute=href
    set global variable  ${HREF_LINKS}

Initial Product Name
    set global variable    ${PRODUCTS_NAME}   '- NO Product Name FOund -'
    [return]    ${PRODUCTS_NAME}

Initial Product Link
    set global variable    ${HREF_LINKS}   '- NO Link Found -'
    [return]    ${HREF_LINKS}

Initial Product Price
    set global variable    ${PRICES}  0.00
    [return]    ${PRICES}