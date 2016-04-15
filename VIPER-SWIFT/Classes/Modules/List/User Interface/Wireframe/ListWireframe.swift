//
//  ListWireframe.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

let ListViewControllerIdentifier = "ListViewController"

public class ListWireframe {
    var rootWireframe : RootWireframe
    var addWireframe : AddWireframe
    private var listPresenter : ListPresenter
    var listViewController : ListViewController?
    
    init(rootWireframe: RootWireframe, addWireframe: AddWireframe, listPresenter : ListPresenter ) {
        self.rootWireframe = rootWireframe
        self.addWireframe = addWireframe
        self.listPresenter = listPresenter
        listPresenter.listWireframe = self
    }
    
    func presentListInterfaceFromWindow(window: UIWindow) {
        let listViewController = listViewControllerFromStoryboard()
        self.listViewController = listViewController
        listViewController.eventHandler = listPresenter
        listPresenter.userInterface = listViewController
        rootWireframe.showRootViewController(listViewController, inWindow: window)
    }
    
    func presentAddInterface() {
        addWireframe.presentAddInterfaceFromViewController(listViewController!)
    }
    
    private func listViewControllerFromStoryboard() -> ListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(ListViewControllerIdentifier) as! ListViewController
        return viewController
    }
    
    private func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
}