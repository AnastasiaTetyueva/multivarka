//
//  RecipeListModel.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 18.12.2020.
//

import Foundation

class RecipeListModel {
    var categories: [ModelCategory] // все данные, связанные с рецептом. Только одни будут показываться в списке рецептов, другие в просмотре самого рецепта
    
    var showOnlyFavorites: Bool = false
    
    init() {
        categories = [ModelCategory(name: "Супы",
                                    recipes: [ModelRecipe(name: "Гороховый",
                                                         previewIcon: "https://img.povar.ru/main/e6/43/f2/09/gorohovii_sup_s_chesnokom_bistro-207168.jpg",
                                                         text: "Замачиваем горох на 2 часа",
                                                         image: "https://static.1000.menu/img/content/2353/gorohovji-sup-s-kuritsei_1495101742_8_max.jpg",
                                                         shortText: "Такой суп вкусный, просто объедение",
                                                         videoURL: "https://youtu.be/uyL9c-xfQy4",
                                                         authorName: "Александр",
                                                         date: "10.10.2020",
                                                         duration: "150 мин.",
                                                         portions: 15,
                                                         likes: 10,
                                                         isFavorite: false)]),
                      ModelCategory(name: "Каши",
                                    recipes: [ModelRecipe(name: "Перловая",
                                                         previewIcon: "https://2recepta.com/recept/perlovaya-kasha/perlovaya-kasha.jpg",
                                                         text: "Замачиваем перловую крупу на ночь",
                                                         image: "https://www.eat-me.ru/wp-content/uploads/2017/09/perlovaya-kasha.jpg",
                                                         shortText: "Каша на любителя",
                                                         videoURL: "https://youtu.be/nCN-l4naM1w",
                                                         authorName: "Александр",
                                                         date: "10.10.2020",
                                                         duration: "150 мин.",
                                                         portions: 15,
                                                         likes: 10000,
                                                         isFavorite: true)])
        
        ]
    }

    func numberOfSections() -> Int {
        return categories.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return getSectionRecipes(section).count
    }
    
    func getSectionRecipes(_ section: Int) -> [ModelRecipe] {
        return categories[section].recipes.filter { (recipe) -> Bool in
            return recipe.isFavorite || !showOnlyFavorites
        }
    }
}
