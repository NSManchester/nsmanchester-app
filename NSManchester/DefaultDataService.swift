//
//  DataService.swift
//  NSManchester
//
//  Created by Ross Butler on 28/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import enum Result.Result

public enum DataError: Error {
    
    // TODO: Extend with all possible cases we wish to handle.
    
    case dataUnavailable // generic error
    case parsingFailure
    
}

class DefaultDataService: DataService {
    
    private let parsingService: ParsingService = ServicesFactory.parsingService()
    
    func mainMenuOptions(callback: @escaping (Result<[MenuOption], DataError>) -> ()) {
        
        callback(Result.success([
            MenuOption(title: "NSManchester", subtitle: "iOS Developer Group", segue: nil, cellIdentifier: "nsmanchester", urlScheme: nil),
            MenuOption(title: "when?", subtitle: nextEventString(), segue: "when", cellIdentifier:"when", urlScheme: nil),
            MenuOption(title: "where?", subtitle: "Madlab, 36-40 Edge Street, Manchester", segue: "where", cellIdentifier:"where", urlScheme: nil),
            MenuOption(title: "we're social!", subtitle: nil, segue: "social", cellIdentifier: "social", urlScheme: nil),
            MenuOption(title: "who?", subtitle: nil, segue: "who", cellIdentifier: "who", urlScheme: nil)
            ]))
        
    }
    
    func socialMenuOptions(callback: @escaping (Result<[MenuOption], DataError>) -> ()) {
        
        callback(Result.success([
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
            ]))
        
    }
    
    func whenMenuOptions(callback: @escaping (Result<[MenuOption], DataError>) -> ()) {
        
        var whenMenuOptions = [MenuOption]()
        
        for event in events()! {
            let menuOption = MenuOption(title: event.date.ordinalString(),
                                        subtitle: "",
                                        segue: nil,
                                        cellIdentifier: "event",
                                        urlScheme: nil)
            whenMenuOptions.append(menuOption)
        }
        
        return callback(Result.success(whenMenuOptions))
        
    }
    
    func eventMenuOptions(_ eventId: Int, callback: @escaping (Result<[MenuOption], DataError>) -> ()) {
        
        var eventMenuOptions = [MenuOption]()
        
        let event = events()![eventId]
        let talks = event.talks
        for talk in talks {
            
            let speaker = speakers()?.filter { $0.speakerID == talk.speaker }.first
            
            var subtitle = ""
            if let speaker = speaker {
                subtitle = String(format: "%@ %@", speaker.forename, speaker.surname)
            }
            
            let menuOption = MenuOption(title: talk.title,
                                        subtitle: subtitle,
                                        segue: nil,
                                        cellIdentifier: "event",
                                        urlScheme: talk.slidesURL?.absoluteString)
            
            eventMenuOptions.append(menuOption)
        }
        
        return callback(Result.success(eventMenuOptions))
        
    }
    
    func todayViewOptions() -> MenuOption {
        return MenuOption(title: nextEventString(), subtitle: "", segue: nil, cellIdentifier:"", urlScheme: nil)
    }
    
    fileprivate func speakers() -> [Speaker]? {
        
        let file = "NSManchester1.1.json"
        
        if let dir: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                   FileManager.SearchPathDomainMask.allDomainsMask, true).first as NSString? {
            let path = dir.appendingPathComponent(file)
            
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return parsingService.parseSpeakers(data: data)
            }
        }
        
        let fileName = Bundle.main.path(forResource: "NSManchester1.1", ofType: "json")
        
        do {
            let data: Data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
            return parsingService.parseSpeakers(data: data)
        } catch _ {
            return []
        }
        
    }
    
    fileprivate func events() -> [Event]? {
        
        let file = "NSManchester1.1.json"
        
        if let dir: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                   FileManager.SearchPathDomainMask.allDomainsMask, true).first as NSString? {
            let path = dir.appendingPathComponent(file)
            
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unsortedEvents = parsingService.parseEvents(data: data)
                return eventsInDescendingOrder(unsortedEvents: unsortedEvents)
            }
        }
        
        let fileName = Bundle.main.path(forResource: "NSManchester1.1", ofType: "json")
        
        do {
            let data: Data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
            let unsortedEvents =  parsingService.parseEvents(data: data)
            
            return eventsInDescendingOrder(unsortedEvents: unsortedEvents)
        } catch _ {
            return []
        }
    }
    
    func eventsInDescendingOrder(unsortedEvents: [Event]?) -> [Event]? {
        
        if let unsortedEvents = unsortedEvents {
            let sortedEvents = unsortedEvents.sorted {
                return $0 > $1
            }
            
            return sortedEvents
        }
        
        return unsortedEvents
    }
    
    fileprivate func nextEventString() -> String {
        
        var nextEvent = "First Monday of each month"
        
        if let events = events(), events.count > 0 {
            nextEvent = events[0].date.ordinalString()
        }
        
        return nextEvent
    }
    
}
