//
//  DataService.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import enum Result.Result

typealias MenuOptionsResult = Result<[MenuOption], DataError>

protocol DataService {
    func mainMenuOptions(callback: @escaping (MenuOptionsResult) -> Void)
    func socialMenuOptions(callback: @escaping (MenuOptionsResult) -> Void)
    func whenMenuOptions(callback: @escaping (MenuOptionsResult) -> Void)
    func eventMenuOptions(_ eventId: Int, callback: @escaping (MenuOptionsResult) -> Void)
    func nextEventString(callback: @escaping (String) -> Void)
}
