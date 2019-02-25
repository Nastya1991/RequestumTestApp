//
//  RecipeResultTableVC_Enum.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import Foundation

extension RecipeResultTableVC {
    
    enum CellIdent : Int {
        case RecipeCell = 0
        
        var name : String {
            let idents = [
                CellIdent.RecipeCell   : "RecipeCell",
                ]
            return idents[self] ?? idents[CellIdent.RecipeCell]!
        }
        
        static func name(val:Int) -> String {
            return CellIdent.RecipeCell.name
        }
    }
    
    enum CellTag : Int
    {
        case Title    = 1
        case Ingrediens     = 2
        case Image   = 3
    }
}
