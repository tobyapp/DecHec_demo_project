//
//  FacebokAuthViewController.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  View controller for the login view, this class displays the Facebook log in and log out button and handles various properties with regards to this

import UIKit
import FBSDKLoginKit
import SwiftyJSON

class FacebokAuthViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var facebookData = FacebookData()

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.view.addBackground("backgroundFour.jpg")
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
//            self.performSegueWithIdentifier("showPage", sender: nil)
 
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
    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        print("User Logged In") //segue to new view
        facebookData.returnUserData()
//        self.performSegueWithIdentifier("showPage", sender: nil) //segue once logged into facebook
        
        if ((error) != nil)
        {
            print("Error : \(error)")
        }
            
        else if result.isCancelled {
            // user cancelled to log in, stay at same page
            print("cancelled")
        }
        else {
            facebookData.returnUserData()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
}
