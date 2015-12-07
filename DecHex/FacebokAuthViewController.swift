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
    
    // facebookData - used to retrieve data form users FB profile + add data to CoreData object
    var facebookData = FacebookData()
    
    // Define Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Used to display side menu (using SWRevealViewController)
        addSideMenu(menuButton)
        
        // Sets views background
        self.view.addBackground("backgroundFour.jpg")
        
        // Function to load the Facebook login/logout button
        func displayFBButton() {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends", "user_likes"]
            loginView.delegate = self
            print("accessed displayFBButton()")
        }
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, display logout button
            displayFBButton()
            facebookData.returnUserData()
            
            // self.performSegueWithIdentifier("showProfilePage", sender: nil) - was used to perform segue, keeping it for refference
        }
        else
        {
            // User isn't logged in, sdisplay login button
            displayFBButton()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Facebook delegate method, check if user logged in successfully
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        // self.performSegueWithIdentifier("showProfilePage", sender: nil) - was used to perform segue, keeping it for refference
        
        if ((error) != nil)
        {
            print("Error : \(error)")
        }
            
        else if result.isCancelled {
            // User cancelled to log in, stay at same page
            print("cancelled")
        }
        else {
            facebookData.returnUserData()
        }
    }
    
    // Function to handle what happens when a user logs out
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
}
