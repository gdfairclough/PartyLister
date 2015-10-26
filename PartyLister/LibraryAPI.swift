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
    private let httpClient: HTTPClient
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
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
    }
    
    //MARK: Event Methods 
    func getEvents()->[Event]{
        
        return persistencyManager.getEvents()
    }
    
    func getEventForIndex(index: Int)->Event{
        
        return persistencyManager.getEventForIndex(index)
    }
    
    func addEvent(newEvent: Event){
        
        persistencyManager.addEvent(newEvent)
    }
    
    func changeEvent(atIndex index: Int, newEvent: Event){
        persistencyManager.changeEvent(atIndex: index, newEvent: newEvent)
    }
    
    
}

