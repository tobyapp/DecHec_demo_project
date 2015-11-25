//
//  FbData+CoreDataProperties.swift
//  DecHex
//
//  Created by Toby Applegate on 24/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FbData {

    @NSManaged var pageLiked: String?
    @NSManaged var likeDate: String?

}
