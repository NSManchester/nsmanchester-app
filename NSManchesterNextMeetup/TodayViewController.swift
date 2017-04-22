//
//  TodayViewController.swift
//  NSManchesterNextMeetup
//
//  Created by Stuart Sharpe on 07/03/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var dateField: UILabel!
    
    // Services
    let dataService: DataService = ServicesFactory.dataService()
    let networkingService: NetworkingService = ServicesFactory.networkingService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Update text field with date of next meetup
        dateField.text = "First Monday of each month"
        dataService.nextEventString(callback: { [weak self] title in
            self?.dateField.text = title
        })
        
    }
    
    @IBAction func goToEvent(_ sender: AnyObject) {
        
        if let url = URL(string: "nsmanchester://") {
            extensionContext?.open(url, completionHandler: nil)
        }
        
    }
    
}
