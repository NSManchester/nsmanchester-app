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
        
        networkingService.update { [weak self] data in
            self?.dateField.text = self?.dataService.todayViewOptions().title
            completionHandler(NCUpdateResult.newData)
        }
        
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets)
        -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
