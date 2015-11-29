//
//  UIViewExtention.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  Extension file to set and manage extensions to various classes

import Foundation

extension UIView {
    func addBackground(backgroundNumber: String) {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: backgroundNumber)

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
