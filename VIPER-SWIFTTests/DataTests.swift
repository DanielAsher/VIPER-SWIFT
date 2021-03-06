//
//  DataStoreTests.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/6/14.
//  Copyright (c) 2014 Conrad Stoll. All rights reserved.
//

import XCTest

class DataTests: XCTestCase {
    var dataStore = CoreDataStore()
    lazy var dataManager : ListDataManager = {ListDataManager(coreDataStore: self.dataStore)}()

    override func setUp() {
        super.setUp()
    }
    
    func testPerformance() {
        self.measureBlock() {
            let startDate = NSDate()
            let endDate = NSDate(timeIntervalSinceReferenceDate: 0)
            self.dataManager.todoItemsBetweenStartDate(startDate, endDate: endDate, completion: { entries in
                
            })
        }
    }

}
