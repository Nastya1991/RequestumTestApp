//
//  BaseEntityProtocol.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

protocol BaseEntityProtocol {
}

extension BaseEntityProtocol where Self : NSManagedObject
{
    static func fetchAllData<T:NSManagedObject>() -> [T]
    {
        if let array = self.mr_findAll() as? [T] {
            return array
        }
        
        return [T]()
    }
    
    static func entity<T:NSManagedObject>(ident:String) -> T?
    {
        if let list = self.mr_find(byAttribute: "ident", withValue: ident) as? [T]
        {
            if let entity = list.first {
                return entity
            }
        }
        
        return nil
    }
    
    static func entitiesValue<T:NSManagedObject>(field:String, value:String) -> T?
    {
        
        if let list = self.mr_find(byAttribute: field, withValue: value) as? [T] {
            if let entity = list.first {
                return entity
            }
        }
        
        return nil
    }
    
    static func entities<T:NSManagedObject>(field:String, value:String) -> [T]?
    {
        if let list = self.mr_find(byAttribute: field, withValue: value) as? [T] {
            return list
        }
        
        return nil
    }
    
    static func entities<T:NSManagedObject>(predicate:NSPredicate) -> [T]?
    {
        if let list = self.mr_findAll(with: predicate) as? [T] {
            return list
        }
        
        return nil
    }
    
    static func createIfNotExist<T:NSManagedObject>(ident:String) -> T?
    {
        if let entity = self.entity(ident:ident)  as? T {
            return entity
        }
        
        let entity = self.mr_createEntity()
        entity?.setValue(ident, forKey: "ident")
        return entity as? T
    }
    
    static func parse<T:NSManagedObject>(data:NSDictionary) -> T? {
        return nil
    }
    
    static func cleanAll()
    {
        if let items = self.mr_findAll()  {
            for item in items {
                item.mr_deleteEntity()
            }
        }
    }

    static func removeAll(_ list:NSSet?)
    {
        guard let array = list?.allObjects as? [NSManagedObject] else {
            return
        }
        
        for item in array {
            item.mr_deleteEntity()
        }
    }
}
