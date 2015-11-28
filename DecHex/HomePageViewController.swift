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
    @IBAction func backgorundChange(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(self.view)
        
        print("Let X : \(translation.x)")
        print("Let Y : \(translation.y)")
        
//        
//        view.backgroundColor = UIColor(red: translation.x, green: translation.y, blue: 1, alpha: 1)
    }
    
    
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

