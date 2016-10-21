//
//  EventsViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 29/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit

class WhenViewController : UIViewController {
    
    @IBOutlet weak fileprivate var tableView: UITableView?
    lazy var menuOptions: [MenuOption] = {
        return DataService().whenMenuOptions()
    }()
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndex = tableView?.indexPathForSelectedRow
        {
            tableView?.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is EventViewController
        {
            let destination = segue.destination as! EventViewController
            let indexPath = tableView?.indexPathForSelectedRow!
            
            destination.titleText = menuOptions[((tableView?.indexPathForSelectedRow as NSIndexPath?)?.row)!].title
            destination.menuOptions = DataService().eventMenuOptions(((tableView?.indexPathForSelectedRow as NSIndexPath?)?.row)!)
            
            // Centralise colours
            destination.backgroundColour = colorFor(indexPath!)
        }
    }
    
    fileprivate func colorFor(_ indexPath: IndexPath) -> UIColor {
        var result : UIColor = UIColor.white
        switch((indexPath as NSIndexPath).row % 3)
        {
        case 0:
            result = UIColor.burntSiennaColor()
        case 1:
            result = UIColor.hopbushColor()
        case 2:
            result = UIColor.waxFlowerColor()
        default: break // Cannot occur mathematically
        }
        return result
    }
}

extension WhenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = menuOptions[(indexPath as NSIndexPath).row].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath);
        
        cell.contentView.backgroundColor = colorFor(indexPath)
        cell.textLabel?.text = menuOptions[(indexPath as NSIndexPath).row].title
        cell.textLabel?.backgroundColor = UIColor.clear
        
        if let subtitle = menuOptions[(indexPath as NSIndexPath).row].subtitle
        {
            cell.detailTextLabel?.text = subtitle
        }
        
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = tableView.cellSelectionColourForCellWithColour(cell.contentView.backgroundColor!)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
}

extension WhenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
