//
//  Talk+JSONDecodable.swift
//  NSManchester
//
//  Created by Ross Butler on 12/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Talk : JSONDecodable {
    
    private enum TalkJSONKeys {
        static let speaker = "speaker"
        static let title = "title"
        static let slides = "slides"
    }
    
    init?(json: JSON) {
        self.init(json: json, speakers: nil)
    }
    
    init?(json: JSON, speakers: [Speaker]? = nil) {
        let speakers = speakers?.filter { (($0.speakerID) == json[TalkJSONKeys.speaker].intValue) }
        guard let newSpeaker = speakers?.first else {
            return nil
        }
        title =  json[TalkJSONKeys.title].stringValue
        speaker = newSpeaker
        slidesURL = URL(string: json[TalkJSONKeys.slides].stringValue)
    }
    
}
