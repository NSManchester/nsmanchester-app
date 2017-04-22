//
//  WhenViewController+UITableViewDataSource.swift
//  NSManchester
//
//  Created by Ross Butler on 18/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import UIKit

extension WhenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = menuOptions[(indexPath as NSIndexPath).row].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = UIColor.cell(for: indexPath).rawValue
        cell.textLabel?.text = menuOptions[(indexPath as NSIndexPath).row].title
        cell.textLabel?.backgroundColor = UIColor.clear
        
        if let subtitle = menuOptions[(indexPath as NSIndexPath).row].subtitle {
            cell.detailTextLabel?.text = subtitle
        }
        
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = tableView.cellSelectionColourForCellWithColour(cell.contentView.backgroundColor!)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
}
