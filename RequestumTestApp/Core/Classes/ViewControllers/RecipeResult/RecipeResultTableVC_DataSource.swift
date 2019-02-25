//
//  RecipeResultTableVC_DataSource.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension RecipeResultTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchRecipesData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ident = CellIdent.name(val: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as UITableViewCell
        
        self.titleLabelCellDecorator(cell, indexPath)
        self.ingredientsLabelCellDecorator(cell, indexPath)
        self.imageCellDecorator(cell, indexPath)
        return cell
    }
    
    // MARK: - Private
    private func titleLabelCellDecorator(_ cell:UITableViewCell, _ indexPath:IndexPath) {
        
        let entity = self.returnRecipeEntity(indexPath.row)
        if let label = cell.viewWithTag(CellTag.Title.rawValue) as? UILabel {
            label.text = entity.title
        }
    }
    
    private func ingredientsLabelCellDecorator(_ cell:UITableViewCell, _ indexPath:IndexPath) {
        
        let entity = self.returnRecipeEntity(indexPath.row)
        if let label = cell.viewWithTag(CellTag.Ingrediens.rawValue) as? UILabel {
            label.text = entity.ingredients
        }
    }
    
    func imageCellDecorator(_ cell:UITableViewCell, _ indexPath:IndexPath)
    {
        if let imageView = cell.viewWithTag(CellTag.Image.rawValue) as? UIImageView {
            let entity = self.returnRecipeEntity(indexPath.row)
            
            entity.image?.loadImage { (image:UIImage) in
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
}
