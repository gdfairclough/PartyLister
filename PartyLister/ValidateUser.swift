//
//  ValidateUser.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/16/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation
import Alamofire


class ValidateUser {
    
    //variables for storing user data
    let username: String
    let password: String
    
    
    init(user: String, password : String){
        
        self.username = user
        self.password = password
    }
    
    //create the JSON object from the username and password data
    //return JSON string
    func createJSONFromUser()->String{
        
        //this will eventually return the JSON object based on the username and
        //password supplied in init
        return "{user: {username: \"faircoder\", password:\"servethepi123\" }}"
        
    }
    
    func validateUser(){
        
        var json = createJSONFromUser()
        
        //create the http get request, this request will pass the user JSON and retirieve the value of
        //true or false from the server, based on if the user exists in the database or not
        //Alamofire framework will be used for sending and receiving http requests
        
        
        
        //getting weird prinouts on occasional runs, possibly due to lack of threading on the server side.
        
        //put request (sets the session value "mystring to "NewString"
        Alamofire.request(.PUT, "http://dalepi.duckdns.org:85", parameters: ["another_string":"NewString!"])
        
        //post request (returns random string value)
        
        Alamofire.request(.POST, "http://dalepi.duckdns.org:85", parameters: ["length":"10"])
        .responseString {
            //code placed in a callback so it is performed asynchronously and doesn't block the main thread
            response in
                print("Post:")
                print("request: \(response.request)")  // original URL request
                print("response: \(response.response)") // URL response
                print("response data \(response.data)")     // server data
                print("response result \(response.result)")   // result of response serialization
                
                if let randString = response.result.value {
                    print("Random String: \(randString)")
                }
        }
        
        Alamofire.request(.GET, "http://dalepi.duckdns.org:85")
            .responseJSON {
                //code placed in a callback so it is performed asynchronously and doesn't block the main thread
                response in
                
                print("Get:")
                print("request: \(response.request)")  // original URL request
                print("response: \(response.response)") // URL response
                print("response data \(response.data)")     // server data
                print("response result \(response.result)")   // result of response serialization
                
                if let anotherString = response.result.value{
                    
                    print("mystring session value is - \(anotherString)")
                }
                
        }
                
        
    }
    
    
    
}