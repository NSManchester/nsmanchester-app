//
//  EventViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 30/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit
import SafariServices
import SVProgressHUD

struct EventCell {
    static let TalkLabelId = 1
    static let AuthorLabelId = 2
}

class EventViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Services
    private let dataService: DataService = ServicesFactory.dataService()
    
    var titleText: String!
    var menuOptions: [MenuOption]?
    var eventID: Int!
    
    var backgroundColour: UIColor?
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(EventViewController.reload(_:)),
                                                name: NSNotification.Name.FeedDataUpdated,
                                                object: nil)
        
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = backgroundColour
        titleLabel?.text = titleText
        
        dataService.eventMenuOptions(eventID, callback: { [weak self] results in
            
            switch results {
                
            case .success(let menuOptions):
                
                self?.menuOptions = menuOptions
                self?.tableView.reloadData()
                
            case .failure( _):
                
                // TODO: Provide feedback e.g. stop activity indicator, present alert view etc.
                
                print("Unable to retrieve menu options.")
            }
            
            })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let tableView = tableView,
            let selectedIndex = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndex, animated: true)
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Notifications
    
    @objc func reload(_ notification: Notification) {
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }

}
