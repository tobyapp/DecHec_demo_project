//
//  HomePageViewController.swift
//  DecHex
//
//  Created by Toby Applegate on 24/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    var facebookData = FacebookData()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground("backgroundOne.jpg")
         //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        facebookData.getProfilePicture {(pictureData, error) -> Void in
            
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            }
            self.imageView.image = UIImage(data: pictureData!)
        }
        
        facebookData.getUserName { (nameData, error) -> Void in
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            }
            self.nameLabel.text = "Wellcome \(nameData!)"
            self.nameLabel.sizeToFit() 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

