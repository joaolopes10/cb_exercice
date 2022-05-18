#App URL and Browser

url = 'http://automationpractice.com/index.php'
browser = 'chrome'

#Generic Element with Text

button_with_text = '//div/*[contains(translate(@title,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz"),"${text}")]'


#Login form

username = '//input[@id="email"]'
password = '//input[@id="passwd"]'
signin   = '//button[@id="SubmitLogin"]'
homebutton = '//a[@title="Home"]'


#Checkoutpage

proced_to_checkout = '//div[@id="center_column"]//a[contains(@title,"Proceed to checkout")]'
process_address = '//button[@type="submit"]/span[contains(text(),"Proceed to checkout")]'
agreement_checkbox = '//input[@id="cgv"]'
payment_method = '//*[@id="HOOK_PAYMENT"]//a[@title="${text}"]'
confirme_order = '//button[@type="submit"]/span[contains(text(),"I confirm my order")]'
order_confirmation_price = '//div[@id="center_column"]//span[@class="price"]'




