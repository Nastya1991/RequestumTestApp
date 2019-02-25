//
//  NetworkResponse.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension NetworkManager {
    
    func handle() {
        guard self.error == nil else  {
            self.failHandle()
            return
        }
        
        switch self.status {
        case .ok     :self.successHandle()
        case .cache  :self.successHandle()
        default      :self.failHandle()
        }
        
    }
    
    func successHandle() {
        self.success(self, self.response)
        self.saveToCache()
    }
    
    func failHandle() {
        self.fail(self.error)
    }
}
