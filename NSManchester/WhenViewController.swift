//
//  EventsViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 29/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit

class WhenViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    // Services
    private let dataService: DataService = ServicesFactory.dataService()
    
    var menuOptions: [MenuOption] = []
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndex = tableView?.indexPathForSelectedRow {
            tableView?.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    override func viewDidLoad() {
        
        dataService.whenMenuOptions(callback: { [weak self] results in
            
            switch results {
            case .success(let menuOptions):
                self?.menuOptions = menuOptions
                self?.tableView.reloadData()
            case .failure( _):
                print("Unable to retrieve menu options.") // TODO: Provide user feedback
            }
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is EventViewController,
            let destination = segue.destination as? EventViewController {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    let selectedRow = selectedIndexPath.row
                    destination.titleText = menuOptions[selectedRow].title
                    destination.eventID = selectedRow
                    destination.backgroundColour = UIColor.cell(for: selectedIndexPath) // Centralise colours
                }
            
        }
        
    }
    
}
