//
//  NetworkRequest.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension NetworkManager {
    
    class var client:Network {
        get {
            let indicator = NetworkIndicator.sharedInstance
            let progress = NetworkProgress.sharedInstanceWithDecorator(decorator: indicator)
            
            return NetworkUI(decorator:progress)
        }
    }
    
    class var quietСlient:Network {
        get {
            let indicator = NetworkIndicator.sharedInstance
            return NetworkUI(decorator:indicator)
        }
    }
    
    func getRecipe(parameters:HttpData, onSuccess: @escaping SuccessClosure , onFailure: @escaping FailureClosure) {
        let endpoint = self.createEndPoint("",parameters)
        request("GET", parameters, endpoint, onSuccess, onFailure, true)
    }
    
    func searchRecipe(parameters:HttpData, onSuccess: @escaping SuccessClosure , onFailure: @escaping FailureClosure) {
        let endpoint = self.createEndPoint("",parameters)
        request("GET", parameters, endpoint, onSuccess, onFailure, false)
    }
    
    private func createEndPoint(_ string:String,_ parameters:HttpData)->String{
        var components = URLComponents(string: string)
        components?.queryItems = parameters.map {
            URLQueryItem(name: $0, value: $1  as? String)
        }
        
        return components?.url?.absoluteString ?? string
    }

}
