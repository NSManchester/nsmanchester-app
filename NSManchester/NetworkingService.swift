//
//  NetworkingService.swift
//  NSManchester
//
//  Created by Ross Butler on 21/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import Result

protocol NetworkingService {
    func dataForURL(_ url: URL, completion: ((Result<Data, NetworkingError>) -> Void)?)
}
