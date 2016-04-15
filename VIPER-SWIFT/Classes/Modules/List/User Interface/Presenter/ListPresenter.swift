//
//  ListPresenter.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ListPresenter : 
    //ListInteractorOutput, 
    ListModuleInterface, AddModuleDelegate {

    let listInteractor : ListInteractor
    var listWireframe : ListWireframe?
    var userInterface : ListViewInterface?

    var disposeBag = DisposeBag()
    
    init(listInteractor: ListInteractor) { //, listWireframe: ListWireframe, userInterface: ListViewInterface?) {
        self.listInteractor = listInteractor
        //self.listWireframe = listWireframe
        //self.userInterface = userInterface
    }
    
    func updateView() {
        listInteractor
        .rx_findUpcomingItems()
        .subscribeNext { upcomingItems in 
            if upcomingItems.count == 0 {
                self.userInterface?.showNoContentMessage()
            } else {
                let collection = UpcomingDisplayDataCollection(upcomingItems)
                self.userInterface?.showUpcomingDisplayData(collection.collectedDisplayData())
            }
        }.addDisposableTo(disposeBag)
    }
        
    func addNewEntry() {
        listWireframe?.presentAddInterface()
    }
    
    func addModuleDidCancelAddAction() {
        // No action necessary
    }
    
    func addModuleDidSaveAddAction() {
        updateView()
    }
}