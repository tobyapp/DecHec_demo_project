//
//  Hex2DecViewController.swift
//  DecHex
//
//  Created by Toby Applegate on 01/10/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import UIKit
import WatchConnectivity

class Hex2DecViewController: UIViewController, WCSessionDelegate{
    var brain = ConverterBrain()
    let dataSession = WCSession.defaultSession()
    var facebookData = FacebookData()
    
    @IBOutlet weak var answerDisplay: UILabel!
    @IBOutlet weak var hexInput: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func convertButton(sender: UIButton) {
        convert(hexInput.text!)
    }
    @IBAction func warningMessage(sender: AnyObject) {
        showAlertController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground("backgroundThree.jpg")
        dataSession.delegate = self
        dataSession.activateSession() //ready to recieve messages from counterpart (may not be nessassery as not sending messages back)
        facebookData.getProfilePicture {(pictureData, error) -> Void in
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            }
            self.imageView.image = UIImage(data: pictureData!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func convert(input : String) {
        print("input is \(input)")
        let convertedNumber = brain.hexToDec(input)
        if let answer = convertedNumber.result {
            print("The answer is \(answer)")
            let stringOfAnswer = String(answer)
            answerDisplay.text = stringOfAnswer
            sendMessageToWatch(input, convertedHexNumber: stringOfAnswer)
        }
        else if let message = convertedNumber.errorMessage {
            print("The answer is \(message)")
            let errorMessage = "\(message)"
            shake(answerDisplay)
            answerDisplay.text = errorMessage
            sendMessageToWatch(input, convertedHexNumber: errorMessage)
        }
    }

    func sendMessageToWatch(decInput : String, convertedHexNumber : String){
        let message = [ "originalNumber": decInput, "newDecNumber": convertedHexNumber, "newHexNumber": ""]
        dataSession.sendMessage(message, replyHandler: nil, errorHandler: nil)
        //replyhandler set to nil as dont want to recieve reply, same with erorr handler
    }
    
    func shake(view: UILabel) {
        let shakeAnimation = CAKeyframeAnimation()
        shakeAnimation.keyPath = "position.x"
        shakeAnimation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        shakeAnimation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        shakeAnimation.duration = 0.5
        shakeAnimation.additive = true
        
        view.layer.addAnimation(shakeAnimation, forKey: "shake")
    }
    
    func showAlertController() {
        let alertController = UIAlertController(
            title: "test title, hey that they both start with a 'T'",
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
        print("done with alert controller")
    }
 
}



