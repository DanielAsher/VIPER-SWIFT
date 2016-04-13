
//
//  UpcomingDisplaySection.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplaySection : Equatable {
    let name : String 
    let imageName : String 
    let items : [UpcomingDisplayItem] 
}

func == (leftSide: UpcomingDisplaySection, rightSide: UpcomingDisplaySection) -> Bool {
    return rightSide.items == leftSide.items
}