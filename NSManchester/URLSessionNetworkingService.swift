//
//  NetworkService.swift
//  NSManchester
//
//  Created by Ross Butler on 15/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let FeedDataUpdated = Notification.Name("feed-data-updated-notification")
}

class URLSessionNetworkingService: NetworkingService {
    
    private let parsingService : ParsingService = ServicesFactory.parsingService()
    
    func update(_ completion: ((Data) -> ())? = nil) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: Endpoints.events.url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] data, response, error in
            
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                
                if let data = data, let _ = self?.parsingService.parseEvents(data: data)
                {
                    
                    let text = String(data: data, encoding: String.Encoding.utf8)
                    
                    let file = "nsmanchester.json"
                    if let dir : String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
                        
                        let dirURL = URL(fileURLWithPath: dir).appendingPathComponent(file);
                        
                        do {
                            
                            try text!.write(toFile: dirURL.path, atomically: false, encoding: String.Encoding.utf8)
                            NotificationCenter.default.post(name: Notification.Name.FeedDataUpdated, object: nil)
                            
                            if let successBlock = completion {
                                successBlock(data)
                            }
                            
                        }
                        catch {
                        }
                    }
                }
            }
            else {
                // Failure
                print("Failure:", error!.localizedDescription);
            }
            });
        task.resume()
    }
}
