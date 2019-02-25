//
//  NetworkStatus.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension NetworkManager {
    
    enum NetworkStatus:Int {
        case error  = 0
        case ok     = 200
        case cache  = 318
        case issue  = 422
    }
}
