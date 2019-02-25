//
//  NetworkCache.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
import Alamofire

class NetworkCache : NSObject {
    
    override init() {
        super.init()
    }
    
    func request(parameters:HttpData, endpoint:String, success:SuccessClosure, fail:FailureClosure) -> Bool {
        if let response = RequestEntity.lastResponse(requestHash: endpoint.hash, paramsHash: parameters.description.hash)
        {
            print("Extracted from cache: \(endpoint)")
            success(nil, response)
            return true
        }
        return false
    }
    
    func save(requestHash:Int, paramsHash:Int, age:Int = 0, response:NSDictionary?) {
        if response != nil {
            
            let interval = Double(age)
            let date     = Date(timeIntervalSinceNow: interval)
            RequestEntity.saveResponse(requestHash: requestHash, paramsHash: paramsHash, expared:date.timeIntervalSince1970, response: response!)
        }
    }
}

class Network: NetworkManager {

    override init() {
        super.init()
    }
    
    override func extractFromCache() -> Bool {
        self.cache         = self.cacheAvailable ? NetworkCache() : nil
        
        var extracted = false
        if let cache = self.cache {
            extracted = cache.request(parameters: self.parameters, endpoint: self.shortEndpoint, success: self.success, fail: self.fail)
        }
        
        return extracted
    }
    
    override func saveToCache() {
        if let cache = self.cache {
            var dataHash = 0
            dataHash = self.data.description.hash
            
            cache.save(requestHash: self.shortEndpoint.hash, paramsHash: dataHash, response: self.response)
        }
    }
}


