//
//  CreateEventViewController.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 10/25/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation
import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var event: Event?{
        
        didSet{
            controllerState = .Update
            
        }
    }
    var eventIndex: Int?
    
    //update and check the state when determining if info is editable
    var controllerState = ControllerState.Create{
        didSet{
            if controllerState == .Display{
                preventEditing()
            }else{
                allowEditing()
            }
        }
    }
    
    
    //View Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        //set controllerState to .Display if userId doesn't match admins for event
        nameField.delegate = self
        locationField.delegate = self
        descriptionField.delegate = self
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //bring the nav bar back
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.barStyle = .Default
        //navigationController?.setNeedsStatusBarAppearanceUpdate()
        
        //event is passed so display the details for editing
        switch controllerState{
        case .Update:
            //change save button to update, or hide if not editable
            saveButton.title = "Update"
            saveButton.enabled = true
            setDisplayInfo()
        case .Display:
            saveButton.enabled = false
            saveButton.title = ""
            setDisplayInfo()
        case .Create:
            //new event is being created
            saveButton.title = "Save"
            saveButton.enabled = true
        }
    }
    
    //on trashcan tap
    @IBAction func deleteEvent(sender: AnyObject) {
    }
    
    
    @IBAction func saveEvent(sender: AnyObject) {
        
        let curId: Int
        if let Id = event?.eventId{
            curId = Id
        }else{
            curId = -1
        }
        let name = nameField.text!
        let description = descriptionField.text!
        let location = locationField.text!
        let start = startPicker.date
        let end = endPicker.date
        let date = datePicker.date
        
       
        let newEvent = Event(id: curId,name: name, location: location, date: date, start: start, end: end, description: description)
      
        
        //update or create an event
        LibraryAPI.sharedInstance.addEvent(newEvent)
        
        print(event?.description)
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func setDisplayInfo(){
        
        if let curEvent = event{
          
            //set fields based on cuEvent info
            nameField.text = curEvent.eventName
            descriptionField.text = curEvent.eventDescription
            locationField.text = curEvent.eventLocation
            startPicker.date = curEvent.eventStart
            endPicker.date = curEvent.eventEnd
            datePicker.date = curEvent.eventDate
            
        }
    }
    
    //TODO: Complete methods to allow and prevent editing
    func allowEditing(){
            
    }
        
    func preventEditing(){
            
            
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        if textView.text == "Enter Event Info"{
            
            textView.text = ""
        }
        
        return true
    }
    
}



enum ControllerState {
    case Create
    case Update
    case Display
}