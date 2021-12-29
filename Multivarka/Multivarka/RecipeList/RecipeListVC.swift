//
//  RecipeListVC.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 18.12.2020.
//


// ТУТ ТАБЛИЦА КАТЕГОРИЙ

import UIKit

class RecipeListVC: UITableViewController {

    var model: RecipeListModel?
    
    var showOnlyFavorites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.showOnlyFavorites = self.showOnlyFavorites

        model?.tableView = tableView
        
        //регистрирую для данной таблицы, что я буду в ней использовать данный тип ячеек
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.tableFooterView = UIView() // скрыть полосочки между пустыми ячейками
    }

    // секции -- это Категории
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.numberOfSections() ?? 0
    }
  // ячейка -- это Рецепт
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.numberOfRowsInSection(section) ?? 0
    }

    // возвращает ячейку для нужной строки секции
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // если ячейка приходит несовместимая с RecipeCell, то возвращаем пустую стандартную таблицу
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? RecipeCell else { return UITableViewCell() }
        let recipe = model?.getSectionRecipes(indexPath.section)[indexPath.row]
        cell.model = recipe
        return cell
    }
    
    // возвращает категорию для списка рецептов
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if model?.numberOfRowsInSection(section) == 0 {
            return nil // не возвращать заголовок секции, если в ней нет ни одного рецепта
        }
        let category = model?.categories[section]
        return category?.name
    }

    // при нажатии на ячейку показываем контроллер рецепта
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = model?.getSectionRecipes(indexPath.section)[indexPath.row]
        let recipeVC = RecipeVC()
        recipeVC.didUpdateModel = { [weak self] (model) in
            self?.model?.updateRecipeModel(model)
            self?.tableView.reloadData()
        }
        recipeVC.model = recipe
        navigationController?.pushViewController(recipeVC, animated: true)
    }
    
    // вызывается, когда мы возвращаемся из рецепта (обновляем и актуализируем данные)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model?.showOnlyFavorites = self.showOnlyFavorites
        model?.fetchData()
    }

}
