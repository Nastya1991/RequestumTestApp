//
//  Database.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import Foundation
import MagicalRecord

class Database : NSObject {
    
    static let sharedInstance = Database()
    
    class func start() {
        self.sharedInstance.start()
    }
    
    class func saveSync()
    {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        print("DB WAS SAVED!")
    }
    
    class func clean()
    {
        RequestEntity.cleanAll()
        Database.saveSync()
    }
    
    class func save(sender:AnyObject, callback:((_ result:Bool)->())? = nil)
    {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (result:Bool, error:Error?) in
            if result {
                print("DB WAS SAVED ASYNC SUCCESS! \(sender)")
                if let callback = callback {
                    callback(true)
                }
            } else {
                if let error = error {
                    print("DB WASN'T SAVED! ERROR \(error.localizedDescription) in \(sender)")
                } else {
                    print("DB WASN'T SAVED! \(sender)")
                }
                if let callback = callback {
                    callback(false)
                }
            }
        }
    }
    
    func start() {
        print("Database started...")
    }
    
    // MARK: - Private

    private override init() {
        super.init()
        self.coreDataInit()
    }
    
    private func coreDataInit() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: "RequestumTestAppModel.sqlite")
    }
}
