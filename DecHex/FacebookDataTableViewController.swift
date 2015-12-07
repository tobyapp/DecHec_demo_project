//
//  FacebookDataTableViewController.swift
//  DecHex
//
//  Copyright © 2015 Toby Applegate. All rights reserved.
//
//  A UITableViewController for the display of the 'liked pages' fomr a users Facebook profile, obtains the data from the CoreData object (FbData)

import UIKit
import CoreData

class FacebookDataTableViewController: UITableViewController {
    
    // managedObjectContext - Managed object to work with objects (Facebook data) in CoreData
    // pagesLikedData - Empty array of CoreData Objects
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var pagesLikedData = [FbData]()
    
    // Define Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        // Used to display side menu (using SWRevealViewController) through class extension as UITableViewController is subclass of UIViewController 
        addSideMenu(menuButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Populates TableView with the same number of UICells as liked pages from Facebook
        return self.pagesLikedData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let dataItem = pagesLikedData[indexPath.row]
        cell.textLabel!.text = dataItem.pageLiked!
        
        // Configures a color gradient for each UICell in TableView
        let redColor = (CGFloat(1) / CGFloat(indexPath.row)) * 6
        let greenColor = CGFloat(0.6)
        let blueColor = CGFloat(0.8)
        cell.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        tableView.separatorColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dataItem = pagesLikedData[indexPath.row]
        
        // Configures background blur effect once a UICell has been selected by user
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.hidden = false
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)

        // Presents alert controller corrisponding to the UICell selected
        let alertController = UIAlertController(title: dataItem.pageLiked!,
            message: "Liked at: \(dataItem.likeDate!)",
            preferredStyle: .Alert)
        let cancelAction    = UIAlertAction(
            title: "Close",
            style: UIAlertActionStyle.Destructive)
            { (action) in
                blurEffectView.hidden = true } //turns blur effect off
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Function fetches Facebook data from CoreData
    func fetchData() {
        let dataFetch  = NSFetchRequest(entityName: "FbData")
        let sortDescriptor = NSSortDescriptor(key: "pageLiked", ascending: true)
        dataFetch.sortDescriptors = [sortDescriptor]
        do {
            let fetchResults = try self.managedObjectContext.executeFetchRequest(dataFetch) as! [FbData]
            pagesLikedData = fetchResults
        }   catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
            }
    }
}
