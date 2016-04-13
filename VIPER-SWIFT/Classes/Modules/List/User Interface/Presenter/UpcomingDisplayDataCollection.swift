//
//  UpcomingDisplayDataCollection.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class UpcomingDisplayDataCollection {
    let dayFormatter = NSDateFormatter()
    var sections : Dictionary<NearTermDateRelation, [UpcomingDisplayItem]> = [:]
    
    init() {
        dayFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("EEEE", options: 0, locale: NSLocale.autoupdatingCurrentLocale())
    }
    
    func addUpcomingItems(upcomingItems: [UpcomingItem]) {
        
        upcomingItems.forEach { item in 
            let day = formattedDay(item.dueDate, dateRelation: item.dateRelation)
            let displayItem = UpcomingDisplayItem(title: item.title, dueDate: day)
            if var realSection = sections[item.dateRelation] {
                realSection.append(displayItem)
                sections[item.dateRelation] = realSection
            } else {
                sections[item.dateRelation] = [displayItem]
            }
        }
    }

    func collectedDisplayData() -> UpcomingDisplayData {
        return UpcomingDisplayData(sections: sortedUpcomingDisplaySections())
    }
    
    private func formattedDay(date: NSDate, dateRelation: NearTermDateRelation) -> String {        
        return dateRelation == NearTermDateRelation.Today ? "" : dayFormatter.stringFromDate(date)
    }
    
    private func displaySectionForDateRelation(dateRelation: NearTermDateRelation) -> UpcomingDisplaySection {
        let sectionTitle = sectionTitleForDateRelation(dateRelation)
        let imageName = sectionImageNameForDateRelation(dateRelation)
        let items = sections[dateRelation] ?? []
        
        return UpcomingDisplaySection(name: sectionTitle, imageName: imageName, items: items )
    }
    
    private func sortedUpcomingDisplaySections() -> [UpcomingDisplaySection] {        
        return sortedNearTermDateRelations()
            .filter { dateRelation in sections[dateRelation] != nil }
            .map { dateRelation in displaySectionForDateRelation(dateRelation) }        
    }
    
    private func sortedNearTermDateRelations() -> [NearTermDateRelation] {
        return [
            NearTermDateRelation.Today, 
            NearTermDateRelation.Tomorrow,
            NearTermDateRelation.LaterThisWeek,
            NearTermDateRelation.NextWeek ]
    }
    
    private func sectionTitleForDateRelation(dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "Today"
        case .Tomorrow:
            return "Tomorrow"
        case .LaterThisWeek:
            return "Later This Week"
        case .NextWeek:
            return "Next Week"
        case .OutOfRange:
            return "Unknown"
        }
    }
    
    private func sectionImageNameForDateRelation(dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "check"
        case .Tomorrow:
            return "alarm"
        case .LaterThisWeek:
            return "circle"
        case .NextWeek:
            return "calendar"
        case .OutOfRange:
            return "paper"
        }
    }
}