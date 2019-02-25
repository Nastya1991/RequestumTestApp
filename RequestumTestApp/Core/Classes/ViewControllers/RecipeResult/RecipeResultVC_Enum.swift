//
//  RecipeResultVC_Enum.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension RecipeResultVC {
    
    enum Segue:String {
        case RecipeSegue = "recipeSegue"
    }
    
    enum CellIdents : Int {
        case RecipeSegue
        var name : String
        {
            let idents = [
                CellIdents.RecipeSegue:"recipeSegue",
                ]
            return idents[self]!
        }
        
        static func name(val:Int) -> String {
            return CellIdents(rawValue:val)?.name ?? CellIdents.RecipeSegue.name
        }
    }
}
