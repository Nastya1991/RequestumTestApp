//
//  RecipeResultVC_SearchBar.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
extension RecipeResultVC : UISearchBarDelegate {
    
    func initSearchBar() {
        self.recipeSearchBar.tintColor = #colorLiteral(red: 0.1748227775, green: 0.534645617, blue: 0.0112334704, alpha: 1)
        self.recipeSearchBar.backgroundColor = #colorLiteral(red: 0.1748227775, green: 0.534645617, blue: 0.0112334704, alpha: 1)
        self.recipeSearchBar.backgroundImage = UIImage()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searhcRecipe(with: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" && searchText == ""{
            searchBar.resignFirstResponder()
            self.searhcRecipe(with: nil)
        }
    }

    
    // MARK: - Private
    private func searhcRecipe(with text : String? ){
        guard let textNotNill = text, textNotNill != "" else {
            self.recipeProviderAction(self.recipeProvider)
            return
        }
         self.searchRecipeProvider.request(textNotNill)
    }

    
}
