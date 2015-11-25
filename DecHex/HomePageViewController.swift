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
                
            //self.imageView.image = UIImage(data: pictureData!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
