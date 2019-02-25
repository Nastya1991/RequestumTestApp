//
//  RecipeEntity_Enum.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
extension RecipeEntity {
    
    enum Field:String
    {
        case results            = "results"
        case image              = "thumbnail"
        case title              = "title"
        case ingredients        = "ingredients"
        case ref                = "href"

        var name : String {
            return self.rawValue
        }
    }
    
}

