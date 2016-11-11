//
//  Endpoints.swift
//  NSManchester
//
//  Created by Ross Butler on 22/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

enum Endpoints {
    
    case events
    case facebook
    case facebookURLScheme
    case meetup
    case twitter
    case twitterURLScheme
    case website
    
    var string: String {
        return self.url.absoluteString
    }
    
    var url: URL {
        
        switch self {
        case .events:
            return URL(string: "https://raw.githubusercontent.com/NSManchester/nsmanchester-app-ios/master/NSManchester/NSManchester.json")!
        case .facebook:
            return URL(string: "https://facebook.com/nsmanchester")!
        case .facebookURLScheme:
            return URL(string: "fb://profile?id=nsmanchester")!
        case .meetup:
            return URL(string: "https://meetup.com/nsmanchester")!
        case .twitter:
            return URL(string: "https://twitter.com/nsmanchester")!
        case .twitterURLScheme:
            return URL(string: "twitter://user?screen_name=nsmanchester")!
        case .website:
            return URL(string: "http://nsmanchester.co.uk")!
        }
        
    }
    
}
