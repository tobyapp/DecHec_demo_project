//
//  FacebokAuthViewController.swift
//  DecHex
//
//  Created by Toby Applegate on 24/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON

class FacebokAuthViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var facebookData = FacebookData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //load facebook display button
        func displayFBButton(){
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends", "user_likes"]
            loginView.delegate = self
            
            print("accessed displayFBButton()")
        }
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // already logged in, display button and perform segue to different view controller
            displayFBButton()
            print("already logged in")
            facebookData.returnUserData()
            self.performSegueWithIdentifier("moveToHomePage", sender: nil)
        }
        else
        {
            //not logged in yet, present button for user to log in
            displayFBButton()
            print("logging in")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        print("User Logged In") //segue to new view
        facebookData.returnUserData()
        self.performSegueWithIdentifier("moveToHomePage", sender: nil) //segue once logged into facebook
        
        if ((error) != nil)
        {
            print("Error : \(error)")
        }
            
        else if result.isCancelled {
            // user cancelled to log in, stay at same page
            print("cancelled")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {

                facebookData.returnUserData()
                let pictureData = facebookData.getProfilePicture()
                print(pictureData)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        //image.removeFromSuperview()  // this removes it from your view hierarchy
        //image = nil;                 // if your reference to it was a strong reference, make sure to `nil
    }
}
