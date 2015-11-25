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
    
    @IBOutlet weak var answerDisplay: UILabel!
    @IBOutlet weak var hexInput: UITextField!
    @IBAction func convertButton(sender: UIButton) {
        convert(hexInput.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSession.delegate = self
        dataSession.activateSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            answerDisplay.text = errorMessage
            sendMessageToWatch(input, convertedHexNumber: errorMessage)
        }
    }

    func sendMessageToWatch(decInput : String, convertedHexNumber : String){
        let message = [ "originalNumber": decInput, "newDecNumber": convertedHexNumber, "newHexNumber": ""]
        dataSession.sendMessage(message, replyHandler: nil, errorHandler: nil)
        //replyhandler set to nil as dont want to recieve reply, same with erorr handler
    }

}



