//
//  ServiceBindings.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

struct ServicesFactory {
    
    static func dataService() -> DataService {
        
        return DefaultDataService()
        
    }
    
    static func networkingService() -> NetworkingService {
        
        return URLSessionNetworkingService()
        
    }
    
    static func parsingService() -> ParsingService {
        
        return SwiftyJSONParsingService()
        
    }
    
    static func persistenceService() -> PersistenceService {
        
        return FilePersistenceService()
        
    }
    
}
