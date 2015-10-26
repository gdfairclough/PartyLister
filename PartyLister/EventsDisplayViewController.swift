//
//  MasterViewController.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/14/15.
//  Copyright © 2015 583. All rights reserved.
//

import UIKit

/**
Allow the user to view the events she has created or is attending

*/
class EventsDisplayViewController: UITableViewController{

    private var events = [Event]()

    override func viewDidLoad() {
        //get the events from the singleton storage API
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let validator = ValidateUser(user: "Dale", password: "foo")
        validator.validateUser()
    }

    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        events = LibraryAPI.sharedInstance.getEvents()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "updateEvent"{
            let dest = segue.destinationViewController as! CreateEventViewController
            let cell = sender as! UITableViewCell
            //determine the index path for the cell
            let indexPath = tableView.indexPathForCell(cell)
            let event = LibraryAPI.sharedInstance.getEventForIndex(indexPath!.row)
            dest.event = event
            dest.eventIndex = indexPath?.row
       }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let event = events[indexPath.row]
        cell.textLabel!.text = event.eventName
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

