//
//  Date+Ordinals.swift
//  NSManchester
//
//  Created by Ross Butler on 18/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     Formats date string appending the appropriate ordinal suffix
     - returns: Formatted date string with appropriate ordinal suffix
     */
    func ordinalString() -> String {
        
        // Format date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        dateFormatter.locale = Locale(identifier: "en_GB")
        var dateStr = dateFormatter.string(from: self)
        
        // Append ordinal suffix
        let calendar = (Calendar(identifier: Calendar.Identifier.gregorian))
        let day = (calendar as NSCalendar).component(.day, from: self)
        let suffixesStr = "|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st"
        let suffixes = suffixesStr.components(separatedBy: "|")
        dateStr.append(suffixes[day])
        return dateStr
        
    }
    
}
