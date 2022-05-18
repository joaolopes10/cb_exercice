*** Settings ***
Test Setup        Open Application
Test Teardown     Close Browser
Resource          ../Resources/PageObject/KeywordDefinationFiles/Common.robot
Variables         ../Resources/PageObject/Locators/locators.py
Resource          ../Resources/PageObject/KeywordDefinationFiles/cart.robot
Variables         ../Resources/PageObject/TestData/item.py

*** Test Cases ***
Add item to the cart and complete purchase order
    [Documentation]    *Description* : The TC adds an item to the cart and complete purchase order
    ...
    ...    *Expected Result*
    ...    - Item(s) was added to cart and price is correct
    ...    - Successful order is complete message
    Login and return to homepage    ${testuser}
    Add Item from the popular list    ${item_data_1}
    I click on the button with the title "Continue shopping"
    The item should be added to the cart    ${item_data_1}
    I click on the button with the title "View my shopping cart"
    I wait and click on the "${proced_to_checkout}" element
    I wait and click on the "${process_address}" element
    I "Accept" the terms and conditions
    I wait and click on the "${process_address}" element
    I select the payment method "Pay by bank wire"
    I wait and click on the "${confirme_order}" element
    Validate the Order confirmation    ${item_data_1}
