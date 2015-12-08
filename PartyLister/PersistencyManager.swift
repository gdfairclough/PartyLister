//
//  PersistencyManager.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/25/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation

class PersistencyManager: NSObject {
    
    //TODO: Different files for different storage?
    
    private var events = [Event]()
    
    func addEvent(newEvent: Event){
        
        events.append(newEvent)
    }
    
    func changeEvent(atIndex index: Int, newEvent: Event){
        events[index] = newEvent
    }
    
    func getEvents()->[Event]{
        return events
    }
    
    func getEventForIndex(index: Int)->Event{
        
        return events[index]
    }
    
    /**
     Update an event by using the id of the event as the key
    */
    func updateEvent(event: Event){
        
        //events.map({$0 = event where $0.eventId = event.eventId})
        
        for i in 0..<events.count{
            if events[i].eventId == event.eventId{
                events[i] = event
                return
            }
        }
        //couldn't find it in the array, so add it
        addEvent(event)
        
    }
}