//
//  EventViewController+UITableViewDelegate.swift
//  NSManchester
//
//  Created by Ross Butler on 17/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import SVProgressHUD

extension EventViewController: UITableViewDelegate {
    
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
    
}
