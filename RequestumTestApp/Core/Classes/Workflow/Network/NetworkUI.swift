//
//  NetworkUI.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import  UIKit

protocol NetworkProgressProtocol {
    func indicateSendingRequest()
    func indicateReceiveResponse()
}

class NetworkUI : Network {
    
    var decorator:NetworkProgressProtocol!
    
    private override init() {
        super.init()
    }
    
    convenience init(decorator:NetworkProgressProtocol) {
        self.init()
        self.decorator = decorator
    }
    
    override func networkSends() {
        self.decorator.indicateSendingRequest()
    }
    
    override func networkResponse() {
        self.decorator.indicateReceiveResponse()
    }
    
}
