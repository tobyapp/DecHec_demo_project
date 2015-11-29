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
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, friends, likes, picture.type(large)"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error    :   \(error)")
            }
            else
            {
                let json = JSON(result)
                let moc = self.managedObjectContext
                //Populate core data with fb pages liked
                for (_, subJson) in json["likes"]["data"] {
                    if let pageLikedName = subJson["name"].string {
                        if let pageLikedDate = subJson["created_time"].string {
                            FbData.createInManagedObjectContext(moc, likeDate: pageLikedDate, pageLiked: pageLikedName)
                        }
                    }
                }
            }
        })
    }
    
    func getProfilePicture(completion: (pictureData: NSData?, error: NSError?) -> Void){
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"picture.type(large)"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            var pictureData: NSData?
            
            if error != nil {
                print("login error: \(error!.localizedDescription)")
                return
            }
            
            let json = JSON(result)
            let profilePicture = json["picture"]["data"]["url"].stringValue
            
            if let url = NSURL(string: profilePicture) {
                pictureData = NSData(contentsOfURL: url)
            }
            completion(pictureData: pictureData, error: error)
        })
    }
    
    func getUserName(completion: (nameData: String?, error: NSError?) -> Void){
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in

            if error != nil {
                print("login error: \(error!.localizedDescription)")
                let userName = "Error, need to log in"
                completion(nameData: userName, error: error)
                return
            }
            
            let json = JSON(result)
            let userName = json["name"].stringValue
            
            completion(nameData: userName, error: error)
        })
    }
}