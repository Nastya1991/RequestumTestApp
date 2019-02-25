//
//  DataProvider.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class DataProvider : UIControl {
    
    typealias Invalidated = DataProvider
    
    var quietСlient = false
    var client:Network {
        get {
            return quietСlient ? Network.quietСlient : Network.client
        }
    }

    var data:AnyObject? {
        didSet {
            DispatchQueue.main.async {
                    self.sendActions(for: .valueChanged)
            }
        }
    }
    
    convenience init(response:AnyObject?)
    {
        self.init()
        print("INVALID DATA of \(String(describing: response)) \(self)")
    }
    
    
    func request() {
    }
    
    func parse(response:AnyObject?) -> DataProvider {
        return self
    }
    func fetch() {
    }
}
