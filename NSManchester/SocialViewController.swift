//
//  SocialViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 30/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit
import SafariServices

class SocialViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    
    // Services
    private let dataService: DataService = ServicesFactory.dataService()
    
    var menuOptions: Array<MenuOption>
    
    // MARK: View lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        
        menuOptions = dataService.socialMenuOptions()
        
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SocialViewController.reload(_:)), name: NSNotification.Name.FeedDataUpdated, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndex = tableView.indexPathForSelectedRow
        {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = menuOptions[(indexPath as NSIndexPath).row].cellIdentifier
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = menuOptions[(indexPath as NSIndexPath).row].title
        
        if let subtitle = menuOptions[(indexPath as NSIndexPath).row].subtitle
        {
            let urlString = subtitle.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "http://", with: "")
            
            cell.detailTextLabel?.text = urlString
        }
        
        cell.contentView.backgroundColor = UIColor.cell(for: indexPath, offset: 2)
        
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = tableView.cellSelectionColourForCellWithColour(cell.contentView.backgroundColor!)
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let urlScheme = menuOptions[(indexPath as NSIndexPath).row].urlScheme
        {
            if(UIApplication.shared.canOpenURL(URL(string:urlScheme)!))
            {
                UIApplication.shared.openURL(URL(string:urlScheme)!)
            }
            else
            {
                let safariViewController = SFSafariViewController(url: URL(string: menuOptions[(indexPath as NSIndexPath).row].subtitle!)!)
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // Notifications
    
    @objc func reload(_ notification: Notification){
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
}
