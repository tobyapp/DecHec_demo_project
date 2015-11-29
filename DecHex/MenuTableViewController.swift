//
//  MenuTableViewController.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  Just a simple UITableViewController for the sidebar menu, can add extra functionality to this class

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets views background
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundSix.JPG"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

 }
