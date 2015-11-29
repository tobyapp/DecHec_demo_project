//
//  WatchInterfaceController.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
// Interface controller for the watch application

import WatchKit
import Foundation
import WatchConnectivity

class WatchInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // dataSession - used to share data between app and watch app (singleton)
    let dataSession = WCSession.defaultSession()
    
    // Define Outlets
    @IBOutlet var originalNumber: WKInterfaceLabel! //inputted by user
    @IBOutlet var decNumber: WKInterfaceLabel! //if converted original number to Dec
    @IBOutlet var hexNumber: WKInterfaceLabel! //if converted original number to Hex

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Activates the dataSession
        dataSession.delegate = self
        dataSession.activateSession()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    // Function to recieve message from sendMessageToWatch() in the converters ViewControllers
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        // Corrisponding values to be displayed from the converters ViewControllers
        let origNumToBeDisplayed = message["originalNumber"] as? String
        let newDecNumber = message["newDecNumber"] as? String
        let newHexNumber = message["newHexNumber"] as? String
        
        hexNumber.setText("Hex: \(newHexNumber!)")
        decNumber.setText("Dec: \(newDecNumber!)")
        originalNumber.setText("Input: \(origNumToBeDisplayed!)")
    }

}
