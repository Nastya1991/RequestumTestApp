//
//  RequestEntity.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import Foundation
import CoreData

extension RequestEntity : BaseEntityProtocol {
    
    class func fetch() -> NSFetchRequest<RequestEntity> {
        return NSFetchRequest<RequestEntity>(entityName: "RequestEntity");
    }
    
    class func lastResponse(requestHash:Int, paramsHash:Int) -> NSDictionary? {
        if let entity = self.entityByHashes(requestHash: requestHash, paramsHash:paramsHash) {
            if let response = entity.response {
                
                do {
                    guard let dict = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(response) as? NSDictionary else {
                        fatalError("Can't get NSDictionary")
                    }
                    return dict
                } catch {
                    fatalError("Can't encode data: \(error)")
                }
            }
        }
        return nil
    }
    
    
    class func entityByHashes(requestHash:Int, paramsHash:Int) -> RequestEntity?
    {
        let predicate = NSPredicate(format: "requestHash = \(requestHash) AND paramsHash = \(paramsHash)")
        let rows = RequestEntity.mr_findAll(with: predicate)
        return rows!.first as? RequestEntity
    }
    
    class func saveResponse(requestHash:Int, paramsHash:Int, expared:TimeInterval ,response:NSDictionary)
    {
        if entityByHashes(requestHash: requestHash, paramsHash: paramsHash) == nil
        {
            let request             = RequestEntity.mr_createEntity()! as RequestEntity
            request.requestHash     = Int64(requestHash)
            request.paramsHash      = Int64(paramsHash)
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: response, requiringSecureCoding: false)
                
                 request.response        =  data
            } catch {
                fatalError("Can't encode data: \(error)")
            }
            request.expireDateTime  = expared
            Database.saveSync()
        }
    }
    
    class func cleanOldData()
    {
        let currentDateTime = Date(timeIntervalSinceNow: 0)
        let currentInterval = currentDateTime.timeIntervalSince1970
        let predicate   = NSPredicate(format: "expireDateTime < \(currentInterval) ")
        let rows = RequestEntity.mr_findAll(with: predicate)
        
        var changed = false
        for entity in rows! {
            entity.mr_deleteEntity()
            changed = true
        }
        
        if changed
        {
            Database.saveSync()
            print(">> Database was cleaned")
        } else {
            print(">> Database includes only an actual data")
        }
    }
}
