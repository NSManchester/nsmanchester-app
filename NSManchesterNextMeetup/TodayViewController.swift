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
        // Do any additional setup after loading the view from its nib.
        
//        // Update text field with date of next meetup
        if let menuOptions = DataService().todayViewOptions() {
            self.dateField.text = menuOptions.title;
        }
        NetworkService().update {
            // Perform any setup necessary in order to update the view.
            if let menuOptions = DataService().todayViewOptions() {
                self.dateField.text = menuOptions.title;
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToEvent(sender: AnyObject) {
        if let url = NSURL(string: "nsmanchester://") {
            extensionContext?.openURL(url, completionHandler: nil)
        }
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        NetworkService().update {
            // Perform any setup necessary in order to update the view.
            if let menuOptions = DataService().todayViewOptions() {
                self.dateField.text = menuOptions.title;
            }
            completionHandler(NCUpdateResult.NewData)
        }

    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    }
    
    
}
