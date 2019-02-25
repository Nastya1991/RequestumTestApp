//
//  RecipeResultTableVC .swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

class RecipeResultTableVC: UITableViewController {
    
    var searchRecipesData : [RecipeEntity] = [] {
        didSet {
            self.tableView.reloadData()
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func returnRecipeEntity(_ index : Int) -> RecipeEntity {
        return self.searchRecipesData[index]
    }    
}
