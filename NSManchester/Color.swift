//
//  Color.swift
//  NSManchester
//
//  Created by Ross Butler on 4/22/17.
//  Copyright © 2017 Ross Butler. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case burntSienna
    case hopbush
    case waxFlower
}

extension Color: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor(red: 238.0/255.0, green: 121.0/255.0, blue: 101.0/255.0, alpha: 1.0):
            self = .burntSienna
            break
        case UIColor(red: 192.0/255.0, green: 105.0/255.0, blue: 155.0/255.0, alpha: 1.0):
            self = .hopbush
            break
        case UIColor(red: 239.0/255.0, green: 173.0/255.0, blue: 150.0/255.0, alpha: 1.0):
            self = .waxFlower
            break
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .burntSienna: return UIColor(red: 238.0/255.0, green: 121.0/255.0, blue: 101.0/255.0, alpha: 1.0)
        case .hopbush: return UIColor(red: 192.0/255.0, green: 105.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        case .waxFlower: return UIColor(red: 239.0/255.0, green: 173.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        }
    }
}
