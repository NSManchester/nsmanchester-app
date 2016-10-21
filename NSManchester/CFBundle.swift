//
//  CFBundle.swift
//  NSManchester
//
//  Created by Sam Meadley on 07/03/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

let kCFBundleShortVersionString = "CFBundleShortVersionString"

extension CFBundle {
    
    func shortVersionString() -> String? {
        let value = CFBundleGetValueForInfoDictionaryKey(self, kCFBundleShortVersionString as CFString!)
        return value as? String
    }
    
}
