//
//  FbData.swift
//  DecHex
//
//  Created by Toby Applegate on 24/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import Foundation
import CoreData


class FbData: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, likeDate: String, pageLiked: String) -> FbData {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("FbData", inManagedObjectContext: moc) as! FbData
        newItem.likeDate = likeDate
        newItem.pageLiked = pageLiked
        
        return newItem
    }
    
}
