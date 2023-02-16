# photosApp
Photo APP

App Details

Photo app used to fetch the photos from https://jsonplaceholder.typicode.com/photos and show the details of the photo and can change the photo name temporary manner

Architetcure - MVVM

MVVM stands for Model View View Model. It describes the flow of our data and the separation of our concerns. The following imagery can represent it.

Components Overview and their roles
View Controller:
It only performs things related to UI — Show/get information. Part of the view layer
View Model: It receives information from VC, handles all this information, and sends it back to VC.
Model: This is only your model, nothing much here. It’s the same model as in MVC. It is used by VM and updates whenever VM sends new updates


UI - xib

In Storyboard using table cell is better then XIB because it gives more flexibility. In Storyboard it is not easy to handle if you have a large amount of code. It is useful only for a small amount of code.

Language - Swift

IDE - Xcode 14

