//
//  ProfileViewController.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  View controller class for the Profile View view controller

import UIKit

class ProfileViewController: UIViewController {

    // facebookData     - used to retrieve data form users FB profile + add data to CoreData object
    var facebookData = FacebookData()
    
    // Define Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Used to display side menu (using SWRevealViewController)
        self.view.addBackground("backgroundOne.jpg")
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = CGFloat(200)
            self.revealViewController().frontViewShadowRadius = CGFloat(50)
            self.revealViewController().frontViewShadowOffset = CGSizeMake(CGFloat(0), CGFloat(5))
            self.revealViewController().frontViewShadowOpacity = CGFloat(1)
            self.revealViewController().frontViewShadowColor = UIColor.darkGrayColor()
        }
        
        // Obtain users Facebook profile picture and set to UIImageView
        facebookData.getProfilePicture {(pictureData, error) -> Void in
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            }
            self.imageView.image = UIImage(data: pictureData!)
        }
        
        // Obtain users Facebook profile name and set to UILabel
        facebookData.getUserName { (nameData, error) -> Void in
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            }
            self.nameLabel.text = "\(nameData!)"
            self.nameLabel.sizeToFit()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
