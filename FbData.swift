//
//  FbData.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  Properties of FbData

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
