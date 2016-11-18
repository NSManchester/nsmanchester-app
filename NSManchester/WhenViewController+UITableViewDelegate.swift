//
//  WhenViewController+UITableViewDelegate.swift
//  NSManchester
//
//  Created by Ross Butler on 18/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import UIKit

extension WhenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
