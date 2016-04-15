//
//  ListInteractor.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import RxSwift

class ListInteractor { //: NSObject, ListInteractorInput {
    //var listPresenter : ListInteractorOutput?
    
    let clock : Clock
    let dataManager : ListDataManager
    
    init(dataManager: ListDataManager, clock: Clock) {
        self.dataManager = dataManager
        self.clock = clock
    }
    
    func rx_findUpcomingItems() -> Observable<[UpcomingItem]> {
        
        let today = clock.today()
        let endOfNextWeek = NSCalendar.currentCalendar().dateForEndOfFollowingWeekWithDate(today)
        
        return Observable<[UpcomingItem]>.create { observer in
            self.dataManager.todoItemsBetweenStartDate(today,
                endDate: endOfNextWeek,
                completion: { todoItems in
                    let upcomingItems = self.upcomingItemsFromToDoItems(todoItems)
                    observer.onNext(upcomingItems)
                    observer.onCompleted()
                }
            )
            return NopDisposable.instance
        }
        .take(1)
    }
        
    func upcomingItemsFromToDoItems(todoItems: [TodoItem]) -> [UpcomingItem] {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        
        var upcomingItems : [UpcomingItem] = []
        
        for todoItem in todoItems {
            let dateRelation = calendar.nearTermRelationForDate(todoItem.dueDate, relativeToToday: clock.today())
            let upcomingItem = UpcomingItem(title: todoItem.name, dueDate: todoItem.dueDate, dateRelation: dateRelation)
            upcomingItems.insert(upcomingItem, atIndex: upcomingItems.endIndex)
        }
        
        return upcomingItems
    }
}