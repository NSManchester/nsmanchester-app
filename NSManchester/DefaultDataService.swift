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
    
    private let queue = DispatchQueue(label: "com.rwbutler.nsmanchester",
                                      qos: .userInitiated,
                                      target: nil)
    private let networkingService: NetworkingService = ServicesFactory.networkingService()
    private let parsingService: ParsingService = ServicesFactory.parsingService()
    private let persistenceService: PersistenceService = ServicesFactory.persistenceService()
    
    func mainMenuOptions(callback: @escaping (MenuOptionsResult) -> Void) {
        
        nextEventString(callback: { nextEventTitle in
            callback(Result.success([
                MenuOption(title: "NSManchester",
                           subtitle: "iOS Developer Group",
                           segue: nil,
                           cellIdentifier: "nsmanchester",
                           urlScheme: nil),
                MenuOption(title: "when?",
                           subtitle: nextEventTitle,
                           segue: "when",
                           cellIdentifier:"when",
                           urlScheme: nil),
                MenuOption(title: "where?",
                           subtitle: "Madlab, 36-40 Edge Street, Manchester",
                           segue: "where",
                           cellIdentifier:"where",
                           urlScheme: nil),
                MenuOption(title: "we're social!",
                           subtitle: nil,
                           segue: "social",
                           cellIdentifier: "social",
                           urlScheme: nil),
                MenuOption(title: "who?",
                           subtitle: nil,
                           segue: "who",
                           cellIdentifier: "who",
                           urlScheme: nil)
                ]))
        })
    }
    
    func socialMenuOptions(callback: @escaping (MenuOptionsResult) -> Void) {
        
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
                       urlScheme: Endpoints.twitterURLScheme.string)
            ]))
        
    }
    
    func whenMenuOptions(callback: @escaping (MenuOptionsResult) -> Void) {
        events(callback: { result in
            switch result {
            case .success(let events):
                let menuOptions = events.map({
                    MenuOption(title: $0.date.ordinalString(),
                               subtitle: "",
                               segue: nil,
                               cellIdentifier: "event",
                               urlScheme: nil)
                })
                callback(.success(menuOptions))
                break
            case .failure(let error):
                callback(.failure(error))
                break
            }
        })
    }
    
    func eventMenuOptions(_ eventId: Int, callback: @escaping (MenuOptionsResult) -> Void) {
        events(callback: { result in
            switch result {
            case .success(let events):
                let event = events[eventId]
                let menuOptions = event.talks.map({
                    MenuOption(title: $0.title,
                               subtitle: String(format: "%@ %@", $0.speaker.forename, $0.speaker.surname),
                               segue: nil,
                               cellIdentifier: "event",
                               urlScheme: $0.slidesURL?.absoluteString)
                })
                callback(.success(menuOptions))
                break
            case .failure(let error):
                callback(.failure(error))
                break
            }
        })
    }
    
    fileprivate func speakers(callback: @escaping (Result<[Speaker], DataError>) -> Void) {
        queue.async { [weak self] in
            self?.networkingService.dataForURL(Endpoints.events.url) { result in
                switch result {
                case .success(let data):
                    if let speakers = self?.parsingService.parseSpeakers(data: data) {
                        DispatchQueue.main.async {
                            callback(.success(speakers))
                        }
                        self?.persistenceService.persistData(data, completion: nil)
                    }
                    break
                case .failure( _):
                    self?.persistenceService.retrieveData(completion: { result in
                        switch result {
                        case .success(let data):
                            if let speakers = self?.parsingService.parseSpeakers(data: data) {
                                DispatchQueue.main.async {
                                    callback(.success(speakers))
                                }
                            }
                            break
                        case .failure( _):
                            // networking failure and unable to retrieve data
                            break
                        }
                    })
                    break
                }
            }
        }
    }
    
    func events(callback: @escaping (Result<[Event], DataError>) -> Void) {
        queue.async { [weak self] in
            self?.networkingService.dataForURL(Endpoints.events.url) { result in
                switch result {
                case .success(let data):
                    if let unsortedEvents = self?.parsingService.parseEvents(data: data),
                        let sortedEvents = self?.eventsInDescendingOrder(unsortedEvents: unsortedEvents) {
                        DispatchQueue.main.async {
                            callback(.success(sortedEvents))
                        }
                        self?.persistenceService.persistData(data, completion: nil)
                    }
                    break
                case .failure( _):
                    self?.persistenceService.retrieveData(completion: { result in
                        switch result {
                        case .success(let data):
                            if let unsortedEvents = self?.parsingService.parseEvents(data: data),
                                let sortedEvents = self?.eventsInDescendingOrder(unsortedEvents: unsortedEvents) {
                                DispatchQueue.main.async {
                                    callback(.success(sortedEvents))
                                }
                            }
                            break
                        case .failure( _):
                            // networking failure and unable to retrieve data
                            break
                        }
                    })
                    break
                }
            }
        }
    }
    
    private func eventsInDescendingOrder(unsortedEvents: [Event]) -> [Event] {
        let sortedEvents = unsortedEvents.sorted {
            return $0 > $1
        }
        return sortedEvents
    }
    
    func nextEventString(callback: @escaping (String) -> Void) {
        self.events(callback: { result in
            switch result {
            case .success(let events):
                if let latestEvent = events.first {
                    callback(latestEvent.date.ordinalString())
                    break
                }
                fallthrough
            case .failure(_):
                callback("First Monday of each month")
                break
            }
        })
    }
}
