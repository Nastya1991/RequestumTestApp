//
//  RecipeResultTableVC_Delegate.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension RecipeResultTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipe = self.returnRecipeEntity(indexPath.row)
        guard let ref = recipe.ref, ref.lenght > 0 else {
            return
        }
        UIApplication.shared.open(URL(string: ref)!, options: [:])
    }
}
