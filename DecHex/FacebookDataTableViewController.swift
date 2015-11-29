//
//  FacebookDataTableViewController.swift
//  DecHex
//
//  Created by Toby Applegate on 24/11/2015.
//  Copyright © 2015 Toby Applegate. All rights reserved.
//

import UIKit
import CoreData

class FacebookDataTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var pagesLikedData = [FbData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addBackground()
        fetchData()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealDisplacement = CGFloat(60)
            self.revealViewController().frontViewShadowRadius = CGFloat(50)
            self.revealViewController().frontViewShadowOffset = CGSizeMake(CGFloat(0), CGFloat(5))
            self.revealViewController().frontViewShadowOpacity = CGFloat(1)
            self.revealViewController().frontViewShadowColor = UIColor.darkGrayColor()

        }
        tableView.tableFooterView = UIView(frame:CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pagesLikedData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) //as UITableViewCell
        let dataItem = pagesLikedData[indexPath.row]
        cell.textLabel!.text = dataItem.pageLiked!
        let blueColor = (CGFloat(1) / CGFloat(indexPath.row)) * 5
        let greenColor = CGFloat(1.0)
        let redColor = CGFloat(1.0)
        cell.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)   //UIColor(red: 0.0, green: 0.5, blue: blueColor, alpha: 1.0)
        tableView.separatorColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dataItem = pagesLikedData[indexPath.row]
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.hidden = false
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)

        let alertController = UIAlertController(title: dataItem.pageLiked!,
            message: "Liked at: \(dataItem.likeDate!)",
            preferredStyle: .Alert)
        let cancelAction    = UIAlertAction(
            title: "Close",
            style: UIAlertActionStyle.Destructive)
            { (action) in
                blurEffectView.hidden = true }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
        
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

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
