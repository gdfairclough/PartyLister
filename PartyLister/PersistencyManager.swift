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
}