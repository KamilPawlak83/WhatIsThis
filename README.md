# WhatIsThis? App

### App Description
This app show us how simple we can get acces to Machine Learning using the CoreML
Firstly You cen get any photo from your photo library or You can take a new one.
When You have a photo You can check - what is this?
You will receive 2 informaton on 2 labels:
* What is this? 
* Chance (in percent) - if the result is closer to 100% the chance that the answer is proper is higher.

Secondly You can save or share this new photo ( tehe new photo contains an original photo and two buttons with answers)

You have acces to all four icons:
photo, photoLibrary, save and share on Toolbar. 
note that you have acces to these icons that should be enabled at this moment. 

#### CoreML Models
I used Resnet50 Model. Of course You can easily swap it to a model that you preffer - You can pick models from this site:
https://developer.apple.com/machine-learning/models/


### What We can learn from this code
* Simple use of CoreML
* How to pick and save a photo in the library
* How to share something via messages,fb, instagram etc.
* Another example o UIAlertController
* String estension 
* How to handle with toolbar and spacer
* How to create views in code using loadView() and NSLayoutConstraint
* and How we can cope with @objc func funcName()
 
### UI

##### App Main View:
![AppView](https://user-images.githubusercontent.com/73897166/133451466-744ca3c3-3e96-46f8-836b-dc8203bcfedf.png)


##### Two examples of result:




