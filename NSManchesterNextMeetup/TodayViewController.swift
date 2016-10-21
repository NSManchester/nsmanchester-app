//
//  TodayViewController.swift
//  NSManchesterNextMeetup
//
//  Created by Stuart Sharpe on 07/03/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var dateField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update text field with date of next meetup
        if let menuOptions = DataService().todayViewOptions() {
            self.dateField.text = menuOptions.title;
        }
        NetworkService().update {
            
            if let menuOptions = DataService().todayViewOptions() {
                self.dateField.text = menuOptions.title;
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goToEvent(_ sender: AnyObject) {
        if let url = URL(string: "nsmanchester://") {
            extensionContext?.open(url, completionHandler: nil)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        NetworkService().update {
            if let menuOptions = DataService().todayViewOptions() {
                self.dateField.text = menuOptions.title;
            }
            completionHandler(NCUpdateResult.newData)
        }
        
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    }
    
    
}
