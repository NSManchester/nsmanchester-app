//
//  ParsingService.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

protocol ParsingService {
    
    func parseEvents(data: Data) -> [Event]
    
    func parseSpeakers(data: Data) -> [Speaker]
    
}
