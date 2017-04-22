//
//  TodayViewController+NCWidgetProviding.swift
//  NSManchester
//
//  Created by Ross Butler on 18/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import NotificationCenter

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        // Update text field with date of next meetup
        dateField.text = "First Monday of each month"
        dataService.nextEventString(callback: { [weak self] title in
            self?.dateField.text = title
            completionHandler(NCUpdateResult.newData)
        })
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets)
        -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
