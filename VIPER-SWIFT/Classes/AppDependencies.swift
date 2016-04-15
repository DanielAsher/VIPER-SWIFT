//
//  AppDependencies.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public class AppDependencies {
    
    public var listWireframe : ListWireframe
    
    var disposeBag = DisposeBag()
    
    init() {
        let coreDataStore = CoreDataStore()
        let clock = DeviceClock()
        
        let listDataManager = ListDataManager(coreDataStore: coreDataStore)
        let listInteractor = ListInteractor(dataManager: listDataManager, clock: clock)
        let listPresenter = ListPresenter(listInteractor: listInteractor)
        
        let addDataManager = AddDataManager(dataStore: coreDataStore)
        let addInteractor = AddInteractor(addDataManager: addDataManager)
        let addPresenter = AddPresenter(addInteractor: addInteractor, addModuleDelegate: listPresenter)
        
        //addPresenter
        //.events
        //.subscribeNext { event in
            //switch event {
            //case .DidSave:
                //listPresenter.addModuleDidSaveAddAction()
            //case .DidCancel:
                //listPresenter.addModuleDidCancelAddAction()
            //}
        //}.addDisposableTo(disposeBag)
        
        let rootWireframe = RootWireframe()
        let addWireframe = AddWireframe(addPresenter: addPresenter)
        
        listWireframe = ListWireframe(rootWireframe: rootWireframe, addWireframe: addWireframe, listPresenter: listPresenter)
                
        
        //addWireframe.addPresenter = addPresenter
        //listPresenter.listInteractor = listInteractor
        //listWireframe.addWireframe = addWireframe
        //addPresenter.addWireframe = addWireframe
        
        
        //listWireframe.rootWireframe = RootWireframe()
        
        //listDataManager.coreDataStore = coreDataStore
        //addInteractor.addDataManager = addDataManager
        
        
        //addPresenter.addModuleDelegate = listPresenter
        //addPresenter.addInteractor = addInteractor
        
        //addDataManager.dataStore = coreDataStore

        //configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        listWireframe.presentListInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        //let coreDataStore = CoreDataStore()
        //let clock = DeviceClock()
        //let rootWireframe = RootWireframe()
        
        //let listDataManager = ListDataManager()
        //let listInteractor = ListInteractor(dataManager: listDataManager, clock: clock)
        //let listPresenter = ListPresenter(listInteractor: listInteractor)
        
        
        
        //listPresenter.listWireframe = listWireframe
        //let addWireframe = AddWireframe()
        //let addInteractor = AddInteractor()
        //let addPresenter = AddPresenter()
        //let addDataManager = AddDataManager()
        
        ////listInteractor.listPresenter = listPresenter
        
        ////listPresenter.listInteractor = listInteractor
        
        //listWireframe.addWireframe = addWireframe
        //listWireframe.listPresenter = listPresenter
        //listWireframe.rootWireframe = rootWireframe
        
        //listDataManager.coreDataStore = coreDataStore
        
        //addInteractor.addDataManager = addDataManager
        
        //addWireframe.addPresenter = addPresenter
        
        //addPresenter.addWireframe = addWireframe
        //addPresenter.addModuleDelegate = listPresenter
        //addPresenter.addInteractor = addInteractor
        
        //addDataManager.dataStore = coreDataStore
    }
}