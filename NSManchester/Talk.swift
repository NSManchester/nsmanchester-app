//
//  Talk.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

struct Talk {
    
    let title: String
    let speaker: Speaker
    let slidesURL: URL?
    
    init?(title: String, speaker: Speaker, slidesURL: URL) {
        self.title = title
        self.speaker = speaker
        self.slidesURL = slidesURL
    }
    
}
