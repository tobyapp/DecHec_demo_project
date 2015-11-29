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
- Plus various other UI elements

## Usage:
This Application connects to Facebook (using supplied credentials) which then using Facebook’s GraphAPI makes a request for various information from a users Facebook profile (such as the users liked pages). The application then displays these in a table view for the user to select while other profile information is used in other parts of the application. The user can then convert hexadecimal values to decimal values (and vice versa) with the results displayed on the paired Apple watch.

## Bugs/Further Work: 	
1. UI Layout: The UI has been designed to work on iPhone 5 and above in portrait mode, landscape mode and iPad support will be added
2. Color gradient of TableViewController: The color gradient will be changed in the table view controller which is displaying the user’s liked Facebook pages to start from white and finish in dark blue to coincide with Facebook’s color scheme
3. Facebook login page: Originally planned was for a Facebook login page to be displayed after which once the user was logged in he/she would be segued to SWRevealViewController but this was not working which resulted in having to create a login/logout page as part of the SWRevealViewController, this will be fixed in the future
4. FBSDK share button: A Facebook share button was going to be displayed once a user converted a number using one of the two applications conversion tools which when pressed, would have a share display pop up (similar to an alert controller) which would share a message such as ‘I just converted XXX to YYY using ZZZ app! Here’s the Github link!’ but this functionality in the FBSDKShareKit was not working
5. Graphing function: A view controller displaying a graph showing the dates of the users liked Facebook page’s will be added to show the amount of pages liked over time
6. Apple Push Certificates: An Apple Push Certificate will be obtained to allow Apple Push Notifications

### Warnings:
-Varios warning messages with regards to used frameworks: Solutions for these were reaserched but could not be found, these will be looked at and fixed in the future
-Assets.xcassets: Adequate AppIcons will be created in the future to replace the existing used ones to resolve warning messages
-Main.storyboard: The frame for “Name Label” will be updated to resolve warning
