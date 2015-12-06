# DecHex_demo_project
The purpose of this demo project is to test and use different iOS functionality, most notably (in no particular order):
- CoreData
- FBSDK (Facebook SDK)
- SwiftyJSON
- SWRevealViewController
- WatchKit
- WatchConnectivity Framework
- CocoaPods
- Class Extensions
- AlertControllers
- MK library
- Plus various other UI elements

## Usage:
This Application connects to Facebook (using separate supplied credentials) through Facebook’s GraphAPI which makes a request for various information from a users Facebook profile (such as the users liked pages, after this has been authorized by the user of course). The application then displays these in a table view for the user to select which will display the date at which the user liked that page while other profile information is used in other parts of the application (such as the users profile display picture and the users name). The user can then convert hexadecimal values to decimal values (and vice versa) with the results displayed on the paired Apple watch (for further intended work on this, see Bugs/Further Work below). 

## Bugs/Further Work: 	
1. UI Layout: The UI has been designed to work on iPhone 5 and above in portrait mode, landscape mode has been partly completed (with regards to objects frames in the Story Board) and iPad support will be added in the future
2. Color gradient of TableViewController: The color gradient will be changed in the table view controller which is displaying the user’s liked Facebook pages to start from white and to finish in dark blue to coincide with Facebook’s color scheme
3. Selecting UICell from TableView with sidebar open: Selecting an UICell from the Facebook TableVIew with the side bar open will reposition the labels associated with each option from the sidebar, this will be fixed in the future 
4. Facebook login page: Originally planned was for the Story Board Entry Point to be located on a Facebook login page after which once the user was logged in he/she would be segued to SWRevealViewController but this was not working which resulted in having to create a login/logout page as part of the SWRevealViewController, this will be fixed in the future
5. FBSDK share button: A Facebook share button was going to be displayed once a user converted a number using one of the two applications conversion tools which when pressed, would have a Share Dialog pop up (similar to an alert controller) which would share a message such as ‘I just converted XXX to YYY using ZZZ app! Here’s the Github link!’ but this functionality in the FBSDKShareKit was not working
6. Graphing function: A view controller displaying a graph showing the dates of the users liked Facebook page’s will be added to show the amount of pages liked over time which will include user interaction to allow the user to select a point in the graph to display the liked page name
7. Apple Push Certificates: An Apple Push Certificate will be obtained to allow Apple Push Notifications
8. Programmatically apply auto layout in Dec2HexViewController.swift and Hex2DecViewController.swift files for buttons of RaisedButton classes

### Warnings:
- Various warning messages with regards to used frameworks: Solutions for these were researched but could not be found, these will be looked at and fixed in the future
- Assets.xcassets: Adequate AppIcons will be created in the future to replace the existing used ones to resolve warning messages
- Main.storyboard: The frame for “Name Label” will be updated to resolve warning
