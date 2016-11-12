//
//  DataService.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import enum Result.Result

protocol DataService {
    
    func mainMenuOptions(callback: @escaping (Result<[MenuOption], DataError>) -> ())
    
    func socialMenuOptions(callback: @escaping (Result<[MenuOption], DataError>) -> ())
    
    func whenMenuOptions(callback: @escaping (Result<[MenuOption], DataError>) -> ())
    
    func eventMenuOptions(_ eventId: Int, callback: @escaping (Result<[MenuOption], DataError>) -> ())
    
    func todayViewOptions() -> MenuOption
    
}
