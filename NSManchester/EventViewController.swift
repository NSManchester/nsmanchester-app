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

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = menuOptions![(indexPath as NSIndexPath).row].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = UIColor.cell(for: indexPath)
        
        let talkLabel = cell.viewWithTag(EventCell.TalkLabelId) as? UILabel
        let authorLabel = cell.viewWithTag(EventCell.AuthorLabelId) as? UILabel
        
        talkLabel?.text = menuOptions![(indexPath as NSIndexPath).row].title
        
        if let subtitle = menuOptions![(indexPath as NSIndexPath).row].subtitle {
            authorLabel?.text = subtitle
        }
        
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = tableView.cellSelectionColourForCellWithColour(cell.contentView.backgroundColor!)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let urlStr = menuOptions?[indexPath.row].urlScheme,
            let url = URL(string: urlStr) {
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "There are no available slides to accompany this talk.")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions!.count
    }
    
    // Notifications
    
    @objc func reload(_ notification: Notification) {
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }

}
