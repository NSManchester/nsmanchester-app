//
//  DataService.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

protocol DataService {
    
    func mainMenuOptions() -> Array<MenuOption>
    
    func socialMenuOptions() -> Array<MenuOption>
    
    func whenMenuOptions() -> Array<MenuOption>
    
    func eventMenuOptions(_ eventId: Int) -> Array<MenuOption>
    
    func todayViewOptions() -> MenuOption
    
}
