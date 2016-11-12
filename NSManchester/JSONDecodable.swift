//
//  JSONDeserialisation.swift
//  NSManchester
//
//  Created by Ross Butler on 12/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 Model objects should conform for JSON deserialisation.
 */

protocol JSONDecodable {
    
    init?(json: JSON)
    
}
