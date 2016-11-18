//
//  Event+JSONDecodable.swift
//  NSManchester
//
//  Created by Ross Butler on 12/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Event: JSONDecodable {
    
    init?(json: JSON) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let parsedDate = dateFormatter.date(from: json["date"].stringValue) else {
            return nil
        }
        
        date = parsedDate
        
        talks = json["talks"].arrayValue.map {
            Talk(json: $0)
        }
        
    }
    
}
