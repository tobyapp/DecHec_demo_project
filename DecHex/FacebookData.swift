//
//  FacebookAuth.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  Class for retrieving various data form user's Facebook profile and storing it in CoreData object (FbData)

import Foundation
import SwiftyJSON
import CoreData

class FacebookData {
    
    // managedObjectContext - Managed object to work with objects (Facebook data) in CoreData
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    // Function to acquire and store various data from Facebook user's profile using CoreData
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, friends, likes, picture.type(large)"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error    :   \(error)")
            }
            else
            {
                // Parses data using SwiftyJSON
                let json = JSON(result)
                let moc = self.managedObjectContext
                
                // Populate CoreData with Facebook pages liked
                for (_, subJson) in json["likes"]["data"] {
                    guard let pageLikedName = subJson["name"].string else {
                        print("Error in getting page liekd name")
                        return
                    }
                    guard let pageLikedDate = subJson["created_time"].string else {
                        print("Error in getting page liekd date")
                        return
                    }
                    FbData.createInManagedObjectContext(moc, likeDate: pageLikedDate, pageLiked: pageLikedName)
                }
            }
        })
    }
    
    // Function to obtain users Facebook profile picture
    func getProfilePicture(completion: (pictureData: NSData?, error: NSError?) -> Void) {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"picture.type(large)"])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            var pictureData: NSData?
            
            if error != nil {
                print("login error: \(error!.localizedDescription)")
                return
            }
            
            // Parses data using SwiftyJSON
            let json = JSON(result)
            let profilePicture = json["picture"]["data"]["url"].stringValue
            
            // Assigns users profile picture to varibale to be returned
            if let url = NSURL(string: profilePicture) {
                pictureData = NSData(contentsOfURL: url)
            }
            
            // Use completion handler to return variables on completion
            completion(pictureData: pictureData, error: error)
        })
    }
    
    // Function to obtain users name form Facebook profile
    func getUserName(completion: (nameData: String?, error: NSError?) -> Void) {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in

            if error != nil {
                print("login error: \(error!.localizedDescription)")
                
                // Return username to be an error if can not obtain username from Facebook
                let userName = "Error, need to log in"
                completion(nameData: userName, error: error)
                return
            }
            
            // Parses data using SwiftyJSON
            let json = JSON(result)
            let userName = json["name"].stringValue
            
            // Use completion handler to return variables on completion
            completion(nameData: userName, error: error)
        })
    }
}