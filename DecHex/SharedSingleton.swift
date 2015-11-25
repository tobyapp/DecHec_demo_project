//
//  SharedSingleton.swift
//  DecHex
//
//  Created by Toby Applegate on 10/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import Foundation

//test singleton class to share data among apps, used WatchConnectivity kit instead
//idea was to try and create object and pass it among classes, used differernt method instead
//kept file in here for refference

class SharedSingleton {
    var originalNumber: String?
    var errorMessage: String?
    var newHexNumber: String?
    var newDecNumber: String?
    static let  sharedInstance = SharedSingleton()
    
}