//
//  Defaults_Strings.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import Foundation

extension Defaults {
    enum Strings : String
    {
        var loc :String {
            return self.rawValue.loc
        }
        case PullToRefresh   = "Pull to refresh"
    }
}
