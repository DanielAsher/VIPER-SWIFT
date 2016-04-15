//
//  AddPresenter.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import RxSwift

class AddPresenter : AddModuleRxInterface { //: AddModuleInterface {
    var addInteractor : AddInteractor
    var addModuleDelegate : AddModuleDelegate
    var addWireframe : AddWireframe?
    
    private var _events = PublishSubject<AddModuleEvent>()
    
    var events : Observable<AddModuleEvent> { return _events.asObservable() }
    
    var disposeBag = DisposeBag()
    
    init(addInteractor: AddInteractor, addModuleDelegate: AddModuleDelegate) {
        self.addInteractor = addInteractor
        self.addModuleDelegate = addModuleDelegate
        
        events
        .subscribeNext { event in
            switch event {
            case .DidSave:
                addModuleDelegate.addModuleDidSaveAddAction()
            case .DidCancel:
                addModuleDelegate.addModuleDidCancelAddAction()
            }
        }.addDisposableTo(disposeBag)
    }
    
    //func cancelAddAction() {
        //addWireframe?.dismissAddInterface()
        //addModuleDelegate.addModuleDidCancelAddAction()
    //}

    func rx_cancelAddAction() -> Observable<AddModuleEvent> {
        addWireframe?.dismissAddInterface()
        _events.onNext(.DidCancel)
        //addModuleDelegate.addModuleDidCancelAddAction()
        return Observable.just(.DidCancel)
    }
    
    //func saveAddActionWithName(name: NSString, dueDate: NSDate) {
        //addInteractor.saveNewEntryWithName(name, dueDate: dueDate);
        //addWireframe?.dismissAddInterface()
        //addModuleDelegate.addModuleDidSaveAddAction()
    //}
    
    func rx_saveAddActionWithName(name: NSString, dueDate: NSDate) -> Observable<AddModuleEvent> {
        addInteractor.saveNewEntryWithName(name, dueDate: dueDate);
        addWireframe?.dismissAddInterface()
        _events.onNext(.DidSave)
        //addModuleDelegate.addModuleDidSaveAddAction()
        return Observable.just(.DidSave)
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: AddViewInterface) {
        addViewUserInterface.setMinimumDueDate(NSDate())
    }
}