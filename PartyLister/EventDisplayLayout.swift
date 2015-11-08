//
//  EventDisplayLayout.swift
//  PartyLister
//
//  Created by Gerald Fairclough on 11/5/15.
//  Copyright © 2015 583. All rights reserved.
//

import UIKit

struct EventLayoutConstants {
    struct Cell {
        //height of non-featured Cell
        static let standardHeight: CGFloat = 100
        //height of the first visible cell
        static let featuredHeight: CGFloat = 280
        
    }
}

class EventDisplayLayout: UICollectionViewLayout {
    
    //MARK: Properties and Values 
    
    // amount user must scroll before featured cell changes
    let dragOffset: CGFloat = 100.0
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    //index of currently featured cell
    var featuredItemIndex: Int{
        
        get{
            //use max to make sure the featuredItemIndex is never < 0 
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    //returns a value between 0 and 1 that represents hwo close the next cell is to becoming the featured cell 
    var nextItemPercentageOffset: CGFloat {
        get{
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    //returns the width of the collection view
    var width: CGFloat {
        
        get{
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    var height:CGFloat {
        
        get{
            return CGRectGetHeight(collectionView!.bounds)
        }
        
    }
    
    var numberOfItems: Int {
        
        get{
            
            return collectionView!.numberOfItemsInSection(0)
            
        }
    }
    
    //MARK: UICollectionViewLayout
    
    //return the size of all content in the collection view
    override func collectionViewContentSize() -> CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        cache.removeAll(keepCapacity: false)
        
        let standardHeight = EventLayoutConstants.Cell.standardHeight
        let featuredHeight = EventLayoutConstants.Cell.featuredHeight
        
        var frame = CGRectZero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            
            //create an index path to the current cell and get its attributes 
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            //prepare item to move up and down by setting the zIndex to item (0 -> numberOfItems) 
            attributes.zIndex = item
            var height = standardHeight
            
            //determine the cell's status (feautured (if), next (else if), or standard (do nothing). 
            if indexPath.item == featuredItemIndex{
                //cell is featured so set its y offset 
                let yOffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            }else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                //cell is next, so calculate teh larget y could be and combine that with a calculated
                //height to end with the correct value of y 
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset,0)
                y = maxY - height
            }
            
            //set up the cell's frame b ased on the above if condition
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            //update y so its at the bottom of the last calculated cell (for calculating next cell frame, position) 
            y = CGRectGetMaxY(frame)
        }
        
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache{
            
            if CGRectIntersectsRect(attributes.frame, rect){
                layoutAttributes.append(attributes)
            }
            
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x:0, y: yOffset)
    }
    
}