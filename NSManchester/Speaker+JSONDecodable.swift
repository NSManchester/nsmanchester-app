//
//  Speaker+JSONDecodable.swift
//  NSManchester
//
//  Created by Ross Butler on 12/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Speaker : JSONDecodable {
    
    private enum SpeakerJSONKeys {
        static let identifier = "id"
        static let forename = "forename"
        static let surname = "surname"
    }
    
    init(json: JSON) {
        speakerID = json[SpeakerJSONKeys.identifier].intValue
        forename =  json[SpeakerJSONKeys.forename].stringValue
        surname = json[SpeakerJSONKeys.surname].stringValue
    }
    
}
