//
//  MenuViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 28/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit
import Foundation

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var versionLabel: UILabel?
    var menuOptions: Array<MenuOption>?
    
    // MARK: View lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        menuOptions = DataService().mainMenuOptions()
        super.init(coder: aDecoder)
        
       NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.reload(_:)), name: NSNotification.Name(rawValue: NSMNetworkUpdateNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let shortVersionString = CFBundleGetMainBundle().shortVersionString() {
            versionLabel?.text = NSLocalizedString("version ", comment: "") + shortVersionString;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(tableView != nil)
        {
            if let selectedIndex = tableView?.indexPathForSelectedRow
            {
                tableView?.deselectRow(at: selectedIndex, animated: true)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellIdentifier = menuOptions?[(indexPath as NSIndexPath).row].cellIdentifier
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath);
        if (indexPath as NSIndexPath).row != 0
        {
            cell.textLabel?.text = menuOptions?[(indexPath as NSIndexPath).row].title
        }
        if let subtitle = menuOptions?[(indexPath as NSIndexPath).row].subtitle
        {
            cell.detailTextLabel?.text = subtitle
        }
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = tableView.cellSelectionColourForCellWithColour(cell.contentView.backgroundColor!)
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menuOptions != nil) ? menuOptions!.count : 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = 80 as CGFloat
        switch((indexPath as NSIndexPath).row)
        {
        case 0:
            height = 300
            break;
        case 1:
            height = 120
            break
        default:
            height = 80
        }
        return height;
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let segueIdentifier = menuOptions?[(indexPath as NSIndexPath).row].segue
        {
            self.performSegue(withIdentifier: segueIdentifier, sender: tableView)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    // Notifications
    
    @objc func reload(_ notification: Notification){
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }
}

