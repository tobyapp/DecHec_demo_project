//
//  WatchInterfaceController.swift
//  DecHex
//
//  Created by Toby Applegate on 10/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class WatchInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    //define outlets
    @IBOutlet var originalNumber: WKInterfaceLabel! //inputted by user
    @IBOutlet var decNumber: WKInterfaceLabel! //if converted original number to Dec
    @IBOutlet var hexNumber: WKInterfaceLabel! //if converted original number to Hex
    
    //returns singleton to be sued between devices
    let dataSession = WCSession.defaultSession()
    
    //init interface controller with context data
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        dataSession.delegate = self
        dataSession.activateSession() //watch app ready to recieve messages fomr iphone app
    }
    
    //ismilar to viewdidload
    override func willActivate() {
        super.willActivate()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        //get values from message dict and assign to constants
        //message = dict of contents from message, as? = "number" might be nil but try to downcast to String type
        let origNumToBeDisplayed = message["originalNumber"] as? String
        let newDecNumber = message["newDecNumber"] as? String
        let newHexNumber = message["newHexNumber"] as? String
        
        //set text of UIFields
        hexNumber.setText("Hex: \(newHexNumber!)") //set text of hexNumber to new converted number enterd form iphone app
        decNumber.setText("Dec: \(newDecNumber!)")//set text of decNumber to new converted number enterd form iphone app
        originalNumber.setText("Input: \(origNumToBeDisplayed!)")
    }

}

