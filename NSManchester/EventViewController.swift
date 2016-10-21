
//
//  EventViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 30/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit

struct EventCell {
    static let TalkLabelId = 1
    static let AuthorLabelId = 2
}

class EventViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var tableView: UITableView?
    
    var titleText: String!
    var menuOptions: Array<MenuOption>?
    var backgroundColour: UIColor?
    
    required init?(coder aDecoder: NSCoder) {
        menuOptions = DataService().whenMenuOptions()
        super.init(coder: aDecoder)
        
         NotificationCenter.default.addObserver(self, selector: #selector(EventViewController.reload(_:)), name: NSNotification.Name(rawValue: NSMNetworkUpdateNotification), object: nil)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = backgroundColour
        titleLabel?.text = titleText
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = menuOptions![(indexPath as NSIndexPath).row].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath);
        
        if ((indexPath as NSIndexPath).row + 1) % 1 == 0
        {
            cell.contentView.backgroundColor = UIColor(red: 238.0/255.0, green: 121.0/255.0, blue: 101.0/255.0, alpha: 1.0)
        }
        if ((indexPath as NSIndexPath).row + 1) % 2 == 0
        {
            cell.contentView.backgroundColor = UIColor(red: 192.0/255.0, green: 105.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        }
        if ((indexPath as NSIndexPath).row + 1) % 3 == 0
        {
            cell.contentView.backgroundColor = UIColor(red: 239.0/255.0, green: 173.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        }
        if ((indexPath as NSIndexPath).row + 1) % 4 == 0
        {
            cell.contentView.backgroundColor = UIColor.green
        }
        
        let talkLabel = cell.viewWithTag(EventCell.TalkLabelId) as? UILabel;
        let authorLabel = cell.viewWithTag(EventCell.AuthorLabelId) as? UILabel;
        
        talkLabel?.text = menuOptions![(indexPath as NSIndexPath).row].title
        
        if let subtitle = menuOptions![(indexPath as NSIndexPath).row].subtitle
        {
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions!.count;
    }
    
    // Notifications
    
    @objc func reload(_ notification: Notification){
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }

}
