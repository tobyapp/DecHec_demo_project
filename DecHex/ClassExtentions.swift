//
//  UIViewExtention.swift
//  DecHex
//
//  Created by Toby Applegate on 25/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import Foundation

extension UIView {
    func addBackground(backgroundNumber: String) {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: backgroundNumber)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleToFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground) 
    }
}

extension NSLayoutConstraint {
    
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}

//extension UITableViewCell {
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        reload()
//    }
//    func reload() {
//        if selected {
//            contentView.backgroundColor = UIColor.redColor()
//            label_checkmark.hidden = false
//        }
//        else {
//            contentView.backgroundColor = UIColor.whiteColor()
//            label_checkmark.hidden = true
//        }
//    }
//}