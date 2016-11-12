//
//  EventsViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 29/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit

class WhenViewController : UIViewController {
    
    // Outlets
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    // Services
    private let dataService: DataService = ServicesFactory.dataService()
    
    var menuOptions: [MenuOption] = []
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndex = tableView?.indexPathForSelectedRow
        {
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
                
                // TODO: Provide feedback e.g. stop activity indicator, present alert view etc.
                
                print("Unable to retrieve menu options.");
            }
            
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is EventViewController
        {
            let destination = segue.destination as! EventViewController
            let indexPath = tableView?.indexPathForSelectedRow!
            
            destination.titleText = menuOptions[((tableView?.indexPathForSelectedRow as NSIndexPath?)?.row)!].title
            
            let row = (tableView?.indexPathForSelectedRow as NSIndexPath?)?.row
            
            destination.eventID = row!
            
            // Centralise colours
            destination.backgroundColour = UIColor.cell(for: indexPath!)
        }
    }
    
    
}

extension WhenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = menuOptions[(indexPath as NSIndexPath).row].cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath);
        
        cell.contentView.backgroundColor = UIColor.cell(for: indexPath)
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
