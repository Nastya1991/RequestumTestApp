//
//  NetworkError.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class ErrorExtension: Error {
    let domain: String
    let code: Int
    
    init(_ dom: String, _ codeInt: Int) {
        self.domain = dom
        self.code = codeInt
    }
}
