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
    
    init(json: JSON) {
        title =  json["title"].stringValue
        speaker = json["speaker"].intValue
    }
    
}
