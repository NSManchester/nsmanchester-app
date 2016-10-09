//
//  NetworkService.swift
//  NSManchester
//
//  Created by Ross Butler on 15/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation

let NSMNetworkUpdateNotification = "network-update-notification"

class NetworkService : NSObject {
    
    func update(completion: (()->())? = nil) {
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://raw.githubusercontent.com/NSManchester/nsmanchester-app/master/NSManchester/NSManchester.json")!)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if (error == nil) {
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                
                if let parsedData = ParsingService().parse(data!)
                {
                    
                    let text = String(data: data!, encoding: NSUTF8StringEncoding)
                    print(parsedData)
                    let file = "nsmanchester.json"
                    if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
                        let path = dir.stringByAppendingPathComponent(file);
                        
                        do {
                            
                            try text!.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
                            NSNotificationCenter.defaultCenter().postNotificationName(NSMNetworkUpdateNotification, object: nil)
                            
                            if let successBlock = completion {
                                successBlock();
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