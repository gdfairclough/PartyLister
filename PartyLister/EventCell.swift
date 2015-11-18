//
//  EventCell.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 11/5/15.
//  Copyright © 2015 583. All rights reserved.
//

import Foundation
import UIKit

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var timeField: UILabel!
    
    @IBOutlet weak var colorVeil: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    var isFeatured = false
    
    var event: Event?{
        
        didSet{
            if let event = event{
                //lazy load all of the properties of the event into the labels
                nameField.text = event.eventName
                dateField.text = String(event.eventDate)
                timeField.text = String(event.eventStart)
            }
        }
    }
    
    //TODO:? set up opacity mask for not featured cells
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        //get the standard and featured heights from the EventLayouyConstantsStruct
        let standardHeight = EventLayoutConstants.Cell.standardHeight
        let featuredHeight = EventLayoutConstants.Cell.featuredHeight
        
        //calculate the opacity
        //delta is calculated as a range of 0 to 1 as it determines the percentage of the height
        //change from the standard height to the featured height cells. From there, the alpha can be
        //calculated as a percentage delta is applied to accpetable alpha range, which is between 0.3 and 0.75 in this case.
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame))/(featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.0
        let maxAlpha: CGFloat = 0.75
        colorVeil.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        //set the alpha for the time and date lables
        dateField.alpha = delta * (maxAlpha - minAlpha)
        timeField.alpha = delta * (maxAlpha - minAlpha)
        
        //set size of event name
        let scale = max(delta, 0.5)
        nameField.transform = CGAffineTransformMakeScale(scale, scale)
        
        if CGRectGetHeight(frame) == featuredHeight {
            addButton.hidden = false
            isFeatured = true
        }else{
            addButton.hidden = true
            isFeatured = false
        }
        
    }
   
    
}