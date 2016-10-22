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
    
    // Outlets
    @IBOutlet weak var dateField: UILabel!
    
    // Services
    private let dataService: DataService = ServicesFactory.dataService()
    private let networkingService: NetworkingService = ServicesFactory.networkingService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Update text field with date of next meetup

        dateField.text = dataService.todayViewOptions().title
        
        networkingService.update { [weak self] in
            self?.dateField.text = self?.dataService.todayViewOptions().title
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
        
        networkingService.update { [weak self] in
            
            self?.dateField.text = self?.dataService.todayViewOptions().title
            completionHandler(NCUpdateResult.newData)
            
        }
        
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    }
    
    
}
