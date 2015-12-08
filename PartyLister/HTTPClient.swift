//
//  HTTPClient.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/25/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation
import Alamofire

class HTTPClient: NSObject {
   
    func addEvent(newEvent: Event){
        
        //format the NSDate for passing via JSON
        let dateFormatter = NSDateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        
        let eventDate = dateFormatter.stringFromDate(newEvent.eventDate)
        let eventStart = dateFormatter.stringFromDate(newEvent.eventStart)
        let eventEnd = dateFormatter.stringFromDate(newEvent.eventEnd)
        let eventId: Int
        if let newEventId = newEvent.eventId {
            
            eventId = newEventId
        }else{
            eventId = -1
        }
        
        let eventDict: [String: AnyObject] =
        [
            "EVENT_INFO": [
                "ID": eventId,
                "NAME": newEvent.eventName,
                "DATE": eventDate,
                "START": eventStart,
                "END": eventEnd,
                "LOCATION": newEvent.eventLocation,
                "DESC": newEvent.eventDescription
            ]
        ]
        
        
        
        
        let valid = NSJSONSerialization.isValidJSONObject(eventDict)
        
        if(valid){
            
            if let eventJSON = JSON(eventDict).rawString(){
                
                
                //create the post request to insert the event
                Alamofire.request(.POST, "http://dalepi.duckdns.org:85/event", parameters: ["event_json":eventJSON])
                    .responseString{
                        response in
                        print("Post:")
                        print("request: \(response.request)")  // original URL request
                        print("response: \(response.response)") // URL response
                        print("response data \(response.data)")     // server data
                        print("response result \(response.result)")   // result of response serialization
                        print("response JSON string: \(response.result.value)")
                }
                
                
            }
        }
        
        
    }
 
    
    func getEvents(){
        
        
    }
    
    func getEventForID(eventID: Int){
        
        
    }
}