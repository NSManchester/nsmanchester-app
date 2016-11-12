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
    
    init(json: JSON) {
        speakerID = json["id"].intValue
        forename =  json["forename"].stringValue
        surname = json["surname"].stringValue
    }
    
}
