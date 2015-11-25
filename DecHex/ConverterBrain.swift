//
//  ConverterBrain.swift
//  DecHex
//
//  Created by Toby Applegate on 01/10/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import Foundation

class ConverterBrain {
    var memory = SharedSingleton()
    
    func hexToDec(hexNumber : String) -> (result: Int?, errorMessage: String?) {
        
        var power = 0
        var total = 0
        let hexString = Array(hexNumber.characters.reverse())
        
        //converts hexidecimal numbers A/a - F/f to the corrisponding decimal numbers
        //if anythign other then A-F entered then throw error and print to screen
        for number in hexString {
            var numberString = String(number)
            switch numberString {
            case "A", "a":
                numberString = "10"
            case "B", "b":
                numberString = "11"
            case "C", "c":
                numberString = "12"
            case "D", "d":
                numberString = "13"
            case "E", "e":
                numberString = "14"
            case "F", "f":
                numberString = "15"
            case  "G", "g", "H", "h", "I", "i", "J", "j", "K", "k", "L", "l", "M", "m", "N",
            "n", "O", "o", "P", "p", "Q", "q", "R", "r", "S", "s", "T", "t", "U", "u", "V", "v", "W", "w", "X", "x", "Y", "y", "Z", "z":
                return(nil, "ERROR")
            default:
                break
            }
            let powerOf: Int = Int(pow(Double(16),Double(power)))
            total = total + (Int(numberString)! * powerOf)
            power++
        }
        return(total, nil)
    }
    
    func decToHex(decNumberInput : String) -> String {
        //see if parameter can be converted to Int, if not return ERROR message
        if let decNumber = Int(decNumberInput) {
            var remainderInHex = decNumber
            var devisionCounter = decNumber
            var stringOfhex = ""
                while devisionCounter != 0 {
                    remainderInHex = devisionCounter % 16
                    devisionCounter = devisionCounter / 16
                    //convert remainder of sum from dec (10-15) to hex equivilants (A-F)
                    switch remainderInHex {
                    case 10:
                        stringOfhex = stringOfhex + "A"
                    case 11:
                        stringOfhex = stringOfhex + "B"
                    case 12:
                        stringOfhex = stringOfhex + "C"
                    case 13:
                        stringOfhex = stringOfhex + "D"
                    case 14:
                        stringOfhex = stringOfhex + "E"
                    case 15:
                        stringOfhex = stringOfhex + "F"
                    default:
                        stringOfhex = stringOfhex + String(remainderInHex)
                    }
                }
            //reverse string and return
            let stringOfhexReversed = stringOfhex.characters.reverse()
            print(String(stringOfhexReversed))
            return(String(stringOfhexReversed))
        }
        else {
            return("ERROR")
        }
    }
}
