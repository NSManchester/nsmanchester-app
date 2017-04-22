//
//  EventViewController+UITableViewDataSource.swift
//  NSManchester
//
//  Created by Ross Butler on 17/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import UIKit

extension EventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = menuOptions![(indexPath as NSIndexPath).row].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = UIColor.cell(for: indexPath).rawValue
        
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

}
