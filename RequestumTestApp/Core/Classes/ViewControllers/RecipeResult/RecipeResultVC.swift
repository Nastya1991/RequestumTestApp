//
//  RecipeResultVC.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class RecipeResultVC: BaseViewController {

    @IBOutlet var searchRecipeProvider: SearchRecipeProvider!
    @IBOutlet var recipeProvider: GetRecipeProvider!
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    
    var tableViewController : RecipeResultTableVC!
    var recipesData : [RecipeEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSearchBar()
        let isEmptyRecipe = RecipeEntity.fetchAllData().count>0 ? false : true
        self.recipeProvider.request(quietСlient: !isEmptyRecipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let identifierOfSegue = segue.identifier else {
            return
        }
        
        if identifierOfSegue == Segue.RecipeSegue.rawValue{
            if let vc = segue.destination as? RecipeResultTableVC {
                self.tableViewController = vc
                self.tableViewController.searchRecipesData =  RecipeEntity.fetchAllData() as [RecipeEntity]
            }
        }
    }

    @IBAction func recipeProviderAction(_ sender: DataProvider) {
        guard let recipes = sender.data as? [RecipeEntity]  else {
            return
        }
        
        if let provider = sender as? GetRecipeProvider {
            self.recipeProvider = provider
        }
        else if let provider = sender as? SearchRecipeProvider {
            self.searchRecipeProvider = provider
        }
        
        self.reloadData(recipes)

    }
    
    func reloadData(_ recipes : [RecipeEntity]) {
        self.recipesData = recipes
        self.tableViewController.searchRecipesData = self.recipesData
    }

}
