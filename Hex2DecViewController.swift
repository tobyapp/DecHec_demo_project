//
//  Hex2DecViewController.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  A view controller for the Hexadecimal to Decimal view

import UIKit
import WatchConnectivity
import MK

class Hex2DecViewController: UIViewController, WCSessionDelegate{
    
    // ConverterBrain() - used to convert Hex-Dec (and vise versa)
    // dataSession      - used to share data between app and watch app (singleton)
    // facebookData     - used to retrieve data form users FB profile + add data to CoreData object
    var brain = ConverterBrain()
    let dataSession = WCSession.defaultSession()
    var facebookData = FacebookData()

    // Define Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var answerDisplay: UILabel!
    @IBOutlet weak var hexInput: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    // Define Actions
    @IBAction func convertButton(sender: UIButton) {
        convert(hexInput.text!)
    }
    @IBAction func warningMessage(sender: AnyObject) {
        //showAlertController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Used to display a custom UIButton to replace the IBAction convert button in storyboard, need to fix auto layout
        let convertButton = RaisedButton(frame: CGRectMake(135, 345, 100, 25))
        convertButton.setTitle("Convert", forState: .Normal)
        convertButton.titleLabel!.font = UIFont(name: "System", size: 15)
        convertButton.addTarget(self, action: "convert2:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(convertButton)
        
        // Used to display a custom UIButton to replace the Test alert Controller button in storyboard, need to fix auto layout
        let warningButton = RaisedButton(frame: CGRectMake(84, 465, 200, 25))
        warningButton.setTitle("Test Alert Controller", forState: .Normal)
        warningButton.titleLabel!.font = UIFont(name: "System", size: 15)
        warningButton.addTarget(self, action: "showAlertController:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(warningButton)
        
        // Used to display side menu (using SWRevealViewController)
        self.addSideMenu(menuButton)

        // Sets views background
        self.view.addBackground("backgroundThree.jpg")
        
        // Activates the dataSession
        dataSession.delegate = self
        dataSession.activateSession()
        
        // Obtain users Facebook profile picture and set to UIImageView
        facebookData.getProfilePicture {(pictureData, error) -> Void in
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            }
            self.imageView.image = UIImage(data: pictureData!)
        }
        
        answerDisplay.textColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Converts the inputted hexadecimal number to decimal 
    func convert2(sender: UIButton!) {
        convert(hexInput.text!)
    }
    
    // Converts the inputted hexadecimal number to decimal 
    func convert(input : String) {
        let convertedNumber = brain.hexToDec(input)
        if let answer = convertedNumber.result {
            let stringOfAnswer = String(answer)
            answerDisplay.text = stringOfAnswer
            
            // Sends the answer to the watch to display
            sendMessageToWatch(input, convertedHexNumber: stringOfAnswer)
        }
        else if let message = convertedNumber.errorMessage {
            let errorMessage = "\(message)"
            shake(answerDisplay)
            answerDisplay.text = errorMessage
            
            // Sends either the error message to the watch to display
            sendMessageToWatch(input, convertedHexNumber: errorMessage)
        }
    }

    // Function to send a message to the watch to display
    func sendMessageToWatch(decInput : String, convertedHexNumber : String) {
        let message = [ "originalNumber": decInput, "newDecNumber": convertedHexNumber, "newHexNumber": ""]
        dataSession.sendMessage(message, replyHandler: nil, errorHandler: nil)
        // Replyhandler set to nil as dont want to recieve reply, same with erorr handler
    }
    
    // Function to make the answerDisplay shake if an input error was detected
    func shake(view: UILabel) {
        let shakeAnimation = CAKeyframeAnimation()
        shakeAnimation.keyPath = "position.x"
        shakeAnimation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        shakeAnimation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        shakeAnimation.duration = 0.5
        shakeAnimation.additive = true
        view.layer.addAnimation(shakeAnimation, forKey: "shake")
    }
    
    // Function to display an Alert Controller (for test purposes)
    func showAlertController(sender: UIButton!) {
        let alertController = UIAlertController(
            title: "test title, hey they both start with a 'T'",
            message: "shouldnt have pressed this button...",
            preferredStyle: .Alert)
        let cancelAction = UIAlertAction(
            title: "Ignore",
            style: UIAlertActionStyle.Destructive,
            handler: nil)
        let otherAction = UIAlertAction(
            title: "Acknowledge (does nothing)",
            style: UIAlertActionStyle.Default,
            handler: {action in print("confirm was tapped")})
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        // Opens the phones settings application
        let openAction = UIAlertAction(
            title: "Open Settings",
            style: .Default)
            { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
        alertController.addAction(openAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
 
}
