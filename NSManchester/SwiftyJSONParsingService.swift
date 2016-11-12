//
//  SwiftyJSONParsingService.swift
//  NSManchester
//
//  Created by Ross Butler on 12/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwiftyJSONParsingService: ParsingService {
    
    func parseEvents(data: Data) -> [Event] {
        
        let json = JSON(data: data)
        
        let events = json["events"].arrayValue.flatMap {
            Event(json: $0)
        }
        
        return events
        
    }
    
    func parseSpeakers(data: Data) -> [Speaker] {
        
        let json = JSON(data: data)
        
        let speakers = json["speakers"].arrayValue.flatMap {
            Speaker(json: $0)
        }
        
        return speakers
        
    }
    
}
