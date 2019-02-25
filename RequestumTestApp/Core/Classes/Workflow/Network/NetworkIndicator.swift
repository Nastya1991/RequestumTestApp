//
//  NetworkIndicator.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class NetworkIndicator : NSObject, NetworkProgressProtocol {
    
    var decorator:NetworkProgressProtocol?
    static let sharedInstance = NetworkIndicator()
    
    private var activeRequestsCounter = 0
    
    private override init() {
        super.init()
    }
    
    class func sharedInstanceWithDecorator(decorator:NetworkProgressProtocol) -> NetworkProgressProtocol {
        self.sharedInstance.decorator = decorator
        return self.sharedInstance
    }
    
    class func show() {
        self.sharedInstance.indicateSendingRequest()
    }
    
    class func hide() {
        self.sharedInstance.indicateReceiveResponse()
    }
    
    func indicateSendingRequest() {
        if let _ = self.decorator {
            self.decorator?.indicateSendingRequest()
        }
        
        DispatchQueue.main.async {
                self.activeRequestsCounter += 1
                if self.activeRequestsCounter == 1 {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
        }
    }
    
    func indicateReceiveResponse() {
        if let _ = self.decorator {
            self.decorator?.indicateReceiveResponse()
        }
        
        DispatchQueue.main.async {
                self.activeRequestsCounter -= 1
                if self.activeRequestsCounter < 1 {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
        }
    }
}
