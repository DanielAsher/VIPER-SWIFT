//
//  UpcomingDisplayItem.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplayItem : Equatable, CustomStringConvertible {
    let title : String
    let dueDate : String
    
    var description : String {
        return "\(title) -- \(dueDate)"
    }
}

func == (leftSide: UpcomingDisplayItem, rightSide: UpcomingDisplayItem) -> Bool {
    return rightSide.title   == leftSide.title 
        && rightSide.dueDate == rightSide.dueDate
}