//
//  NSJSONSerializationParsingService.swift
//  NSManchester
//
//  Created by Ross Butler on 15/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

// TODO: Create ParsingService implementation without NSJSONSerialization - result in too many if-lets.

class JSONSerializationParsingService : ParsingService {
    
    func parseEvents(data: Data) -> [Event]? {
        
        var result = Array<Event>()
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            
            if let speakers = json?.object(forKey: "speakers") as? NSDictionary,
                let events = json?.object(forKey: "events") as? NSArray
            {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_GB")
                dateFormatter.dateStyle = DateFormatter.Style.short
                
                // Iterate over events array
                for event in events {
                    
                    // Treat each event as an NSDictionary
                    if let eventDictionary = event as? NSDictionary {
                        
                        var talks = Array<Talk>()
                        
                        if let talkDate = eventDictionary.object(forKey: "date") as? String,
                            let date = dateFormatter.date(from: talkDate),
                            let tempTalks = eventDictionary.object(forKey: "talks") as? NSArray {
                            
                            for talk in tempTalks {
                                
                                if let talkDictionary = talk as? NSDictionary,
                                    let speakerStr = talkDictionary.object(forKey: "speaker"),
                                    let speakerDict = speakers.object(forKey: speakerStr) as? NSDictionary,
                                    let speakerForename = speakerDict.object(forKey: "forename") as? String,
                                    let speakerSurname = speakerDict.object(forKey: "surname") as? String,
                                    let title = talkDictionary.object(forKey: "title") as? String
                                {
                                    let speaker = Speaker(forename: speakerForename, surname: speakerSurname)
                                    let talk = Talk(title: title, speaker: speaker)
                                    talks.append(talk)
                                }
                                
                            }
                            
                            let evt = Event(date: date, talks: talks)
                            result.append(evt)
                        }
                        
                    }
                }
            }
        } catch let error as NSError {
            NSLog("%@", error)
        }
        
        return (result.count > 0) ? result : nil;
    }
}
