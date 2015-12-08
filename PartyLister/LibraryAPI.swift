//
//  EventSharedStore.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/25/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation

class LibraryAPI: NSObject {
    
    private let persistencyManager: PersistencyManager
    private let serverClient: HTTPClient
    private let isOnline: Bool
    
    //used to access the EventStore
    class var sharedInstance: LibraryAPI {
        
        struct Singleton{
            
            static let instance = LibraryAPI()
        }
        
        return Singleton.instance
    }
    
    override init() {
        persistencyManager = PersistencyManager()
        serverClient = HTTPClient()
        isOnline = false
        
        super.init()
    }
    
    //MARK: Event Methods 
    func getEvents()->[Event]{
        
        //attempt to load events from server if empty
        
        return persistencyManager.getEvents()
    }
    
    func getEventForIndex(index: Int)->Event{
        //attempt to load events from server if empty 
        
        return persistencyManager.getEventForIndex(index)
    }
    
    func addEvent(newEvent: Event){
        //add event if id is -1, otherwise update
        if newEvent.eventId == -1 {
            persistencyManager.addEvent(newEvent)
        }else{
            persistencyManager.updateEvent(newEvent)
        }
        serverClient.addEvent(newEvent)
    }
  
    
    func testEventCreate(){
        
        let date = NSDate()
        
        let event = Event(id: 0, name: "Celebrate Samhain", location: "Noelle's", date: date, start: date, end: date, description: "Woot")
        
        serverClient.addEvent(event)
    }
    
    
}

