//
//  DataService.swift
//  NSManchester
//
//  Created by Ross Butler on 28/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

class DefaultDataService: DataService {
    
    private let parsingService : ParsingService = JSONSerializationParsingService()
    
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
            MenuOption(title: "website",
                       subtitle: Endpoints.website.string,
                       segue: nil,
                       cellIdentifier: "link",
                       urlScheme: Endpoints.website.string),
            MenuOption(title: "meetup",
                       subtitle: Endpoints.meetup.string,
                       segue: nil,
                       cellIdentifier: "link",
                       urlScheme: Endpoints.meetup.string),
            MenuOption(title: "facebook",
                       subtitle: Endpoints.facebook.string,
                       segue: nil,
                       cellIdentifier: "link",
                       urlScheme: Endpoints.twitterURLScheme.string),
            MenuOption(title: "twitter",
                       subtitle: Endpoints.twitter.string,
                       segue: nil,
                       cellIdentifier: "link",
                       urlScheme: Endpoints.twitterURLScheme.string),
        ];
    }
    
    func whenMenuOptions() -> Array<MenuOption> {
        
        var whenMenuOptions = Array<MenuOption>()
        
        for event in events()!
        {
            let menuOption = MenuOption(title: dateAsString(event.date as Date), subtitle: "", segue: nil, cellIdentifier: "event", urlScheme: nil)
            whenMenuOptions.append(menuOption)
        }
        
        return whenMenuOptions
    }
    
    func eventMenuOptions(_ eventId: Int) -> Array<MenuOption> {
        
        var eventMenuOptions = Array<MenuOption>()
        
        let event = events()![eventId]
        let talks = event.talks
        for talk in talks
        {
            var subtitle = talk.speaker.forename
            subtitle.append(" ")
            subtitle.append(talk.speaker.surname)
            let menuOption = MenuOption(title: talk.title, subtitle: subtitle, segue: nil, cellIdentifier: "event", urlScheme: nil)
            eventMenuOptions.append(menuOption)
        }
        return eventMenuOptions
    }
    
    func todayViewOptions() -> MenuOption {
        return MenuOption(title: nextEventString(), subtitle: "", segue: nil, cellIdentifier:"", urlScheme: nil);
    }
    
    fileprivate func events() -> Array<Event>? {
        
        let file = "nsmanchester.json"
        
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first as NSString? {
            let path = dir.appendingPathComponent(file);
            
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            {
                let unsortedEvents = parsingService.parse(data: data)
                return sortEventsInDescendingOrder(unsortedEvents: unsortedEvents)
            }
        }
        
        let fileName = Bundle.main.path(forResource: "NSManchester", ofType: "json");
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
        let unsortedEvents =  parsingService.parse(data: data)
        
        return sortEventsInDescendingOrder(unsortedEvents: unsortedEvents)
    }
    
    func sortEventsInDescendingOrder(unsortedEvents: Array<Event>?) -> Array<Event>? {
        
        if let unsortedEvents = unsortedEvents
        {
            let sortedEvents = unsortedEvents.sorted {
                return $0 > $1
            }
            
            return sortedEvents
        }
        
        return unsortedEvents
    }
    
    fileprivate func nextEventString() -> String {
        
        var nextEvent = "First Monday of each month"
        
        if let events = events(), events.count > 0
        {
            nextEvent = dateAsString(events[0].date as Date)
        }
        
        return nextEvent
    }
    
    fileprivate func dateAsString(_ date: Date) -> String {
        
        // Format date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        dateFormatter.locale = Locale(identifier: "en_GB")
        var dateStr = dateFormatter.string(from: date)
        
        // Append ordinal suffix
        let calendar = (Calendar(identifier: Calendar.Identifier.gregorian))
        let day = (calendar as NSCalendar).component(.day, from: date)
        let suffixesStr = "|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st"
        let suffixes = suffixesStr.components(separatedBy: "|")
        dateStr.append(suffixes[day])
        return dateStr
    }
    
}
