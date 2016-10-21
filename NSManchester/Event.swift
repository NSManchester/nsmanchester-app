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
