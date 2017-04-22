//
//  PersistenceService.swift
//  NSManchester
//
//  Created by Ross Butler on 22/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import Result

protocol PersistenceService {
    func persistData(_ data: Data, completion: ((Data) -> Void)?)
    func retrieveData(completion: ((Result<Data, PersistenceError>) -> Void))
}
