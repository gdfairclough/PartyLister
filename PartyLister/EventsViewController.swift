//
//  EventsViewController.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 11/5/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation
import UIKit

class EventsViewController: UICollectionViewController{
    
    var events = [Event]()
    let palette = UIColor.palette()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
        collectionView?.backgroundColor = UIColor.clearColor()
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        
        let date = NSDate()
        
        let event = Event(id: 0, name: "Celebrate Samhain", location: "Noelle's", date: date, start: date, end: date, description: "Woot")
        events.append(event)
        LibraryAPI.sharedInstance.addEvent(event)
        var event1 = Event(id: 0, name: "Cow Party", location: "Matt's", date: date, start: date, end: date, description: "Woot")
        events.append(event1)
        LibraryAPI.sharedInstance.addEvent(event1)
        event1 = Event(id: 0, name: "Cow Tipping", location: "Dale's", date: date, start: date, end: date, description: "Woot")
        events.append(event1)
        LibraryAPI.sharedInstance.addEvent(event1)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "updateEvent"{
            
            let cell = sender as! EventCell
            if cell.isFeatured{
                return true
            }else{
                return false
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updateEvent"{
            
            let indexPath = collectionView?.indexPathForCell(sender as! EventCell)
            
            let dest = segue.destinationViewController as! CreateEventViewController
            dest.event = LibraryAPI.sharedInstance.getEventForIndex(indexPath!.item)
            dest.eventIndex = indexPath!.item
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.navigationBar.hidden = true
        navigationController?.navigationBar.barStyle = .Black
        
        events = LibraryAPI.sharedInstance.getEvents()
        collectionView?.reloadData()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Event", forIndexPath: indexPath) as! EventCell
        cell.event = events[indexPath.item]
        cell.backgroundColor = palette[indexPath.row]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let layout = collectionViewLayout as! EventDisplayLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        
        if collectionView.contentOffset.y != offset{
        collectionView.setContentOffset(CGPoint(x:0, y: offset),animated: true)
        }
    }
    
    
    
}