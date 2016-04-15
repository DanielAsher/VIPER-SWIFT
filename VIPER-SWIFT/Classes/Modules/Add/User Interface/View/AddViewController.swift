//
//  AddViewController.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AddViewController: UIViewController, UITextFieldDelegate, AddViewInterface {
    var eventHandler : AddModuleRxInterface?

    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var datePicker : UIDatePicker?
    
    var minimumDate : NSDate = NSDate()
    var transitioningBackgroundView : UIView = UIView()
    
    var disposeBag = DisposeBag()
    
    @IBAction func save(sender: AnyObject) {
        eventHandler?
        .rx_saveAddActionWithName(nameTextField.text!, dueDate: datePicker!.date)
        .subscribeNext { evt in }
        .addDisposableTo(disposeBag)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        eventHandler?
        .rx_cancelAddAction()
        .subscribeNext { evt in }
        .addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(AddViewController.dismiss))
        
        transitioningBackgroundView.userInteractionEnabled = true
        
        nameTextField.becomeFirstResponder()
        
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = minimumDate
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        nameTextField.resignFirstResponder()
    }
    
    func dismiss() {
        eventHandler?
        .rx_cancelAddAction()
        .subscribeNext { evt in }
        .addDisposableTo(disposeBag)
    }
    
    func setEntryName(name: NSString) {
        nameTextField.text = name as String
    }
    
    func setEntryDueDate(date: NSDate) {
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = date
        }
    }
    
    func setMinimumDueDate(date: NSDate) {
        minimumDate = date
        
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = date
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}