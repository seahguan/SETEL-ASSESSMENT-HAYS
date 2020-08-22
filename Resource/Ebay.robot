*** Settings ***
Resource  ../Resource/PO/LandingPage.robot
Resource  ../Resource/PO/TopNavSection.robot
Resource  ../Resource/PO/SearchResult.robot
Resource  ../Resource/PO/Product.robot
Resource  ../Resource/PO/ShoppingCart.robot
Resource  ../Resource/PO/SignIn.robot

*** Keywords ***
Load Page
    [Arguments]    ${URL}
    LandingPage.Load    ${URL}
    LandingPage.Verify EbayPage Loaded

Search for Products
    [Arguments]    ${SEARCH_TERM}
    wait until page contains    ebay
    TopNavSection.Search for Products   ${SEARCH_TERM}
#    SearchResult.Verify Search Completed   ${SEARCH_TERM}

Select Product from Search Results
    SearchResult.Click Product link
    Product.Verify Product Details Page Loaded

Add Product to Cart
    Product.Add to Cart
    ShoppingCart.Verify Product Added

Begin Checkout
    ShoppingCart.Proceed to Checkout
    SignIn.Verify Page Loaded

Sign In Using Mobile
    [Arguments]    ${MOBILE_NO}  ${PASSWORD}
    TopNavSection.Sign In
    SignIn.Verify Page Loaded
    SignIn.Login with Mobile NO  ${MOBILE_NO}   ${PASSWORD}

Verify Cart Type 2
    Verify added Cart Type2

Remove and Item from Cart
    ShoppingCart.Remove and Item from Cart

Proceed Checkout
    searchResult.Click Proceed to checkout Button

Verify Sign-In Page
    wait until page contains    Sign-In

Sign In Using UserName
    [Arguments]    ${EMAIL_ADDR}  ${PASSWORD}
    TopNavSection.Sign In
    SignIn.Verify Page Loaded
    SignIn.Login with Email  ${EMAIL_ADDR}  ${PASSWORD}

Sign In Using Incorrect Mobile NO
    [Arguments]    ${MOBILE_NO}
    TopNavSection.Sign In
    SignIn.Verify Page Loaded
    SignIn.Login with Invalid Mobile NO  ${MOBILE_NO}

Sign In Using Incorrect Email Acc
    [Arguments]    ${EMAIL_ADDR}
    TopNavSection.Sign In
    SignIn.Verify Page Loaded
    SignIn.Login with Invalid acc   ${EMAIL_ADDR}