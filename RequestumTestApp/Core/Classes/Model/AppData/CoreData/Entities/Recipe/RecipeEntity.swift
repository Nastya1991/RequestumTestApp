//
//  RecipeEntity.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension  RecipeEntity : BaseEntityProtocol {
    
    class func parse(data:[NSDictionary])->[RecipeEntity] {
        var recipes:[RecipeEntity]  = []
        for value in data {
            if let entity = self.parseEntity(value: value){
                recipes.append(entity)
            }
        }
        return recipes
    }
    
    class func parseEntity(value:NSDictionary)->RecipeEntity?  {
        guard let title     = value[Field.title.name]       as? String,
            let ref  = value[Field.ref.name]    as? String,
            let ingredients  = value[Field.ingredients.name]    as? String,
            let image  = value[Field.image.name]    as? String
            else {
                return nil
        }
        
        
        var tempEntity = RecipeEntity.entitiesValue(field: Field.title.name, value: title) as? RecipeEntity
        
        if tempEntity == nil || (tempEntity?.ingredients != ingredients && tempEntity?.ref != ref && tempEntity?.image != image ) {
            tempEntity = RecipeEntity.mr_createEntity()
        }
        tempEntity?.title = title.removingNewlines
        tempEntity?.ref = ref
        tempEntity?.ingredients = ingredients.removingNewlines
        tempEntity?.image = image
        Database.saveSync()
        
        return tempEntity
    }
}
