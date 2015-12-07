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
        
        // Sets views background
        self.view.addBackground("backgroundOne.jpg")
        
        // Used to display side menu (using SWRevealViewController)
        addSideMenu(menuButton)
        
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
