//
//  DataService.swift
//  NSManchester
//
//  Created by Ross Butler on 28/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

struct MenuOption {
    let title : String
    let subtitle : String?
    let segue : String?
    let cellIdentifier : String
    let urlScheme : String?
}

class DataService: NSObject {
    
    func mainMenuOptions() -> Array<MenuOption> {
        return [
            MenuOption(title: "NSManchester", subtitle: "iOS developer group", segue: nil, cellIdentifier: "nsmanchester", urlScheme: nil),
            MenuOption(title: "when?", subtitle: nextEventString(), segue: "when", cellIdentifier:"when", urlScheme: nil),
            MenuOption(title: "where?", subtitle: "Madlab, 36-40 Edge Street, Manchester", segue: "where", cellIdentifier:"where", urlScheme: nil),
            MenuOption(title: "we're social!", subtitle: nil, segue: "social", cellIdentifier: "social", urlScheme: nil),
            MenuOption(title: "who?", subtitle: nil, segue: "who", cellIdentifier: "who", urlScheme: nil)
        ];
    }
    
    func socialMenuOptions() -> Array<MenuOption> {
        return [
            MenuOption(title: "facebook", subtitle: "https://www.facebook.com/nsmanchester", segue: nil, cellIdentifier: "facebook", urlScheme: "fb://profile?id=nsmanchester"),
            MenuOption(title: "twitter", subtitle: "https://www.twitter.com/nsmanchester", segue: nil, cellIdentifier:"twitter", urlScheme: "twitter://user?screen_name=nsmanchester")
        ];
    }
    
    func whenMenuOptions() -> Array<MenuOption> {
        
        var whenMenuOptions = Array<MenuOption>()
        
        for event in events()!
        {
            let menuOption = MenuOption(title: dateAsString(event.date), subtitle: "", segue: nil, cellIdentifier: "event", urlScheme: nil)
            whenMenuOptions.append(menuOption)
        }
        
        return whenMenuOptions
    }
    
    func eventMenuOptions(eventId: Int) -> Array<MenuOption> {
        
        var eventMenuOptions = Array<MenuOption>()
        
        let event = events()![eventId]
        let talks = event.talks
        for talk in talks
        {
            var subtitle = talk.speaker.forename
            subtitle.appendContentsOf(" ")
            subtitle.appendContentsOf(talk.speaker.surname)
            let menuOption = MenuOption(title: talk.title, subtitle: subtitle, segue: nil, cellIdentifier: "event", urlScheme: nil)
            eventMenuOptions.append(menuOption)
        }
        return eventMenuOptions
    }
    
    func todayViewOptions() -> MenuOption? {
        return MenuOption(title: nextEventString(), subtitle: "", segue: nil, cellIdentifier:"", urlScheme: nil);
    }
    
    private func events() -> Array<Event>? {
        
        let file = "nsmanchester.json"
        
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(file);
            
            if let data = NSData(contentsOfFile: path)
            {
                return ParsingService().parse(data)
            }
        }
        let fileName = NSBundle.mainBundle().pathForResource("NSManchester", ofType: "json");
        let data: NSData = try! NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
        return ParsingService().parse(data)
    }
    
    private func nextEventString() -> String {
        var nextEvent = "First Monday of each month"
        if let events = events()
        {
            if events.count > 0
            {
                nextEvent = dateAsString(events[0].date)
            }
        }
        return nextEvent
    }
    
    private func dateAsString(date: NSDate) -> String {
        
        // Format date string
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_GB")
        var dateStr = dateFormatter.stringFromDate(date)
        
        // Append ordinal suffix
        let calendar = (NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!)
        let day = calendar.component(.Day, fromDate: date)
        let suffixesStr = "|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st"
        let suffixes = suffixesStr.componentsSeparatedByString("|")
        dateStr.appendContentsOf(suffixes[day])
        return dateStr
    }
    
}