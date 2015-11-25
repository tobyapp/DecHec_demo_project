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
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var pagesLikedData = [FbData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
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
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dataItem = pagesLikedData[indexPath.row]
        print(dataItem.likeDate!)

        let alertController = UIAlertController(title: dataItem.pageLiked!,
            message: "Liked at: \(dataItem.likeDate!)",
            preferredStyle: .Alert)
        let cancelAction    = UIAlertAction(
            title: "Close",
            style: UIAlertActionStyle.Destructive,
            handler: nil)
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
