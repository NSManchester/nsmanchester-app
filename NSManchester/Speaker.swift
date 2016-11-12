//
//  Speaker.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

struct Speaker {
    
    let speakerID: Int
    let forename: String
    let surname: String
    
    init(speakerID: Int, forename: String, surname: String) {
        self.speakerID = speakerID
        self.forename = forename
        self.surname = surname
    }
    
}
