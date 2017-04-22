//
//  FilePersistenceService.swift
//  NSManchester
//
//  Created by Ross Butler on 22/10/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import Result

public enum PersistenceError: Error {
    case bundledDataRetrievalError(error: Error)
}

/**
 Simplistic data store implementation
 */
class FilePersistenceService: PersistenceService {
    
    private let dataFile = (fileName: "NSManchester1.1", fileExtension: "json")
    private let userInitiatedQueue = DispatchQueue(label: "com.rwbutler.nsmanchester",
                                                   qos: .userInitiated,
                                                   target: nil)
    
    func persistData(_ data: Data, completion: ((Data) -> Void)? = nil) {
        
        userInitiatedQueue.async { [weak self] in
            
            if let fileName = self?.dataFile.fileName, let fileExtension = self?.dataFile.fileExtension {
                
                let file = fileName + "." + fileExtension
                let text = String(data: data, encoding: String.Encoding.utf8)
                
                if let dir: String = NSSearchPathForDirectoriesInDomains(
                    FileManager.SearchPathDirectory.documentDirectory,
                    FileManager.SearchPathDomainMask.allDomainsMask,
                    true).first {
                    
                    let dirURL = URL(fileURLWithPath: dir).appendingPathComponent(file)
                    
                    do {
                        
                        try text!.write(toFile: dirURL.path, atomically: false, encoding: String.Encoding.utf8)
                        NotificationCenter.default.post(name: Notification.Name.FeedDataUpdated, object: nil)
                        
                        if let successBlock = completion {
                            DispatchQueue.main.async {
                                successBlock(data)
                            }
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    func retrieveData(completion: ((Result<Data, PersistenceError>) -> Void)) {
        
        let file = dataFile.fileName + "." + dataFile.fileExtension
        
        if let dir: NSString = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.allDomainsMask,
            true).first as NSString? {
            let path = dir.appendingPathComponent(file)
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                completion(.success(data))
            } catch _ {
            }
        }
        
        let fileName = Bundle.main.path(forResource: dataFile.fileName, ofType: dataFile.fileExtension)
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: fileName!),
                                options: NSData.ReadingOptions(rawValue: 0))
            completion(.success(data))
        } catch let error {
            completion(.failure(.bundledDataRetrievalError(error: error)))
        }
    }
    
}
