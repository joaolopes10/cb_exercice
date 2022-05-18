*** Settings ***
Library           SeleniumLibrary
Variables         ../Locators/locators.py
Variables         ../TestData/users.py
Library           Collections
Resource          Common.robot

*** Variables ***

*** Keywords ***
Add Item from the popular list
    [Arguments]    ${dic}
    [Documentation]    This Keyword add's an Item from the popular Items list, that match the given Name and Price
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${dic} \ | Dictionary Item name |
    ...
    ...    *Examples: * | Add Item from the popular list ${item_data_1}
    ${count}    Get Element Count    //ul[@id="homefeatured"]//li
    &{row_value}    Create Dictionary
    FOR    ${i}    IN RANGE    1    ${count}+1
        ${title}    Get Element Attribute    (//ul[@id="homefeatured"]/li//div[@class="left-block"]//a[@class="product_img_link"])[${i}]    title
        ${price}    Get Element Attribute    (//ul[@id="homefeatured"]/li//div[@class="left-block"]//span[@class="price product-price"])[${i}]    innerHTML
        Set To Dictionary    ${row_value}    name=${title}    total_products=${price.strip()}
        ${found}    Run Keyword And Return Status    Dictionary Should Contain Sub Dictionary    ${dic}    ${row_value}
        Exit For Loop If    ${found}
    END
    Should Be True    ${found}    msg="There is no Item that match the folowing dictionary: " ${dic}
    ${element}    Replace Variables    (//ul[@id="homefeatured"]/li//div[@class="right-block"]//a[@title="Add to cart"])[${i}]
    Execute Javascript    document.evaluate('${element}',document.body,null,9,null).singleNodeValue.click();
    Wait Until Element Is Visible    //div[@id="layer_cart"]    timeout=${timeout}

The item should be added to the cart
    [Arguments]    ${dic}
    [Documentation]    This Keyword validates that the item it's added to the cart
    ...
    ...    *Input Arguments*
    ...
    ...    | ${dic} \ | Dictionary Item name |
    ...
    ...    *Examples: *
    ...    - The item should be added to the cart ${item_data_1}
    ${count}    Get Element Count    //div[@class="cart-info"]
    &{row_value}    Create Dictionary
    FOR    ${i}    IN RANGE    1    ${count}+1
        ${title}    Get Element Attribute    (//a[@class="cart_block_product_name"])[${i}]    title
        ${price}    Get Element Attribute    (//span[@class="price"])[${i}]    innerHTML
        ${total}    Get Element Attribute    //span[@class="price cart_block_total ajax_block_cart_total"]    innerHTML
        ${shipping}    Get Element Attribute    //span[@class="price cart_block_shipping_cost ajax_cart_shipping_cost"]    innerHTML
        Set To Dictionary    ${row_value}    name=${title}    total_products=${price.strip()}    total_shipping=${shipping.strip()}    total_price_final=${total.strip()}
        ${found}    Run Keyword And Return Status    Dictionary Should Contain Sub Dictionary    ${dic}    ${row_value}
        Exit For Loop If    ${found}
    END
    Should Be True    ${found}    msg="There is no Item that match the folowing dictionary: " ${dic}

I "${option}" the terms and conditions
    [Documentation]    This Keyword
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${option} | Accept or Refuse Terms and conditions |
    ...
    ...
    ...    *Examples: *
    ...
    ...    - I "Accept" the terms and conditions
    ...    - I "Refuse" the terms and conditions
    Wait Until Page Contains Element    ${agreement_checkbox}    timeout=${timeout}
    Run Keyword If    "${option.lower()}"=="accept"    Select Checkbox    ${agreement_checkbox}
    ...    ELSE    Unselect Checkbox    ${agreement_checkbox}

I select the payment method "${text}"
    [Documentation]    This Keyword Selects on Payment Method
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${text} | Payment Method Title |
    ...
    ...
    ...    *Examples: *
    ...    - I select the payment method "Pay by bank wire"
    ${element}    Replace Variables    ${payment_method}
    Wait Until Page Contains Element    ${element}    timeout=${timeout}
    Click Element    ${element}

Validate the Order confirmation
    [Arguments]    ${dic}
    [Documentation]    This Keyword Validate the order confirmation Values are correct
    ...
    ...    *Input Arguments*
    ...
    ...    | Argument | Summary |
    ...    | ${dic} | Dictionary Item name |
    ...
    ...    *Examples: *
    ...    - Validate the Order confirmation ${item_data_1}
    &{page_values}    Create Dictionary
    Wait Until Page Contains    Your order on My Store is complete.    timeout=${timeout}
    ${cart_total_price}    get text    ${order_confirmation_price}
    Set To Dictionary    ${page_values}    cart_total_price=${cart_total_price}
    Dictionary Should Contain Sub Dictionary    ${dic}    ${page_values}
    Capture Page Screenshot
