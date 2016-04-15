//
//  AddModuleInterface.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import RxSwift

protocol AddModuleRxInterface {
    var events : Observable<AddModuleEvent> { get }
    func rx_cancelAddAction() -> Observable<AddModuleEvent>
    func rx_saveAddActionWithName(name: NSString, dueDate: NSDate) -> Observable<AddModuleEvent> 
}

protocol AddModuleInterface {
    func cancelAddAction()
    func saveAddActionWithName(name: NSString, dueDate: NSDate)
}