//
//  FileStorage.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class FileStorage : NSObject {
    
    private let databasePath = "/Caches/Database"

    var cachesPath:String {
        let appPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        return appPath.first! + self.databasePath
    }
}

