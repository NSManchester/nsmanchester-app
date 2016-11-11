//
//  Event.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

struct Event {
    
    let date: Date
    let talks: Array<Talk>
    
    init(date: Date, talks: Array<Talk>) {
        self.date = date
        self.talks = talks
    }
    
}

// For now, should be sufficient to compare event dates

extension Event: Equatable {
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.date == rhs.date
    }
    
}

extension Event: Comparable {
    
    static func <=(lhs: Event, rhs: Event) -> Bool {
        return lhs.date <= rhs.date
    }
    
    static func >(lhs: Event, rhs: Event) -> Bool {
        return lhs.date > rhs.date
    }
    
    static func >=(lhs: Event, rhs: Event) -> Bool {
        return lhs.date >= rhs.date
    }
    
    static func <(lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
    
}
