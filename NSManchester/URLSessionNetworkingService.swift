//
//  NetworkService.swift
//  NSManchester
//
//  Created by Ross Butler on 15/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import Result

extension Notification.Name {
    static let FeedDataUpdated = Notification.Name("feed-data-updated-notification")
}

public enum NetworkingError: Error {
    case dataUnavailable
}

class URLSessionNetworkingService: NetworkingService {
    
    private let parsingService: ParsingService = ServicesFactory.parsingService()
    
    func dataForURL(_ url: URL, completion: ((Result<Data, NetworkingError>) -> Void)? = nil) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: Endpoints.events.url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] data, _, error in
            
            if error == nil {
                
                if let data = data, let _ = self?.parsingService.parseEvents(data: data) {
                    
                    if let successBlock = completion {
                        successBlock(.success(data))
                    }
                    
                }
            } else {
                // Failure
                print("Failure:", error!.localizedDescription)
            }
        })
        task.resume()
    }
}
