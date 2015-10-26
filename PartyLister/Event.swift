//
//  Event.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/25/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation

class Event: NSObject {
    
    var eventId: Int?
    let eventName: String
    let eventLocation: String
    let eventDate: NSDate
    let eventStart: NSDate
    let eventEnd: NSDate
    let eventDescription: String
    
    init(id: Int = -1, name: String, location: String, date: NSDate, start: NSDate, end: NSDate, description: String){
        
        eventName = name
        eventLocation = location
        eventDate = date
        eventStart = start
        eventEnd = end
        eventDescription = description
        
        //assign the eventId if id is not zero
        if id != -1 {
            eventId = id
        }
        
    }
    
    override var description: String {
        
            return "id: \(eventId) name: \(eventName) location: \(eventLocation) date: \(eventDate) start: \(eventStart) end: \(eventEnd) description: \(eventDescription)"
    
    }
    
}