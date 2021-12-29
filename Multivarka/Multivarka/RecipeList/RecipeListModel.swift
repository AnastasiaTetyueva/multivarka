//
//  RecipeListModel.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 18.12.2020.
//

import Foundation
import UIKit

class RecipeListModel {
    var categories: [Category] = [] // все данные, связанные с рецептом. Только одни будут показываться в списке рецептов, другие в просмотре самого рецепта
    var categoryRecipes: [Int: [Recipe]] = [:]

    var showOnlyFavorites: Bool = false
    
    var tableView: UITableView?
    
    func fetchData() {
        CategoryControllerAPI.readUsingGET() { [weak self] (categories, error) in
            print("categories: \(categories)")
            self?.categories = categories ?? []
            
            var categoryRecipes: [Int: [Recipe]] = [:]
            let group = DispatchGroup()
            
            for i in categories ?? [] {
                group.enter()
                RecipeControllerAPI.readUsingGET3(categoryId: i.id, isPreview: true, isFavorite: self?.showOnlyFavorites ?? false) { (recipes, error) in
                    print("recipes: \(recipes)")
                    categoryRecipes[i.id] = recipes
                    
                    
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self?.categoryRecipes = categoryRecipes
                self?.tableView?.reloadData()
            }
        }
        
    }
    
    init() {
        
    }
    
    
    func numberOfSections() -> Int {
        return categories.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return getSectionRecipes(section).count
    }
    
    func getSectionRecipes(_ section: Int) -> [Recipe] {
        let categoryId = categories[section].id
        return categoryRecipes[categoryId] ?? []
    }
    
    func updateRecipeModel(_ model: Recipe) {
        let tmp = categoryRecipes[model.categoryId]
        let recipes = tmp?.reduce([Recipe](), { (result, i) -> [Recipe] in
            var result = result
            result.append((i.id == model.id) ? model : i)
            return result
        })
        categoryRecipes[model.categoryId] = recipes
    }
}
