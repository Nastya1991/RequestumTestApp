//
//  GetRecipeProvider.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class GetRecipeProvider: DataProvider {
   
    private var recipeObjs: [RecipeEntity]?
    
    func request(quietСlient : Bool) {
        let data = ["i":"onions,garlic","q":"omelet","p":"3"]
        self.quietСlient = quietСlient
        self.client.getRecipe(parameters: data as HttpData, onSuccess: { (sender, response) in
            self.parse(response: response).fetch()
        }) { (error) in
             print(error ?? "UNKNOW ERROR IN \(self)")
        }
    }
    
    override func parse(response: AnyObject?) -> DataProvider {
        guard let data = response!["results"] as? [NSDictionary] else {
            return Invalidated(response: response)
        }
        self.recipeObjs = RecipeEntity.parse(data: data)
        return self
    }
    
    override func fetch() {
        self.data = self.recipeObjs as AnyObject
    }
}
