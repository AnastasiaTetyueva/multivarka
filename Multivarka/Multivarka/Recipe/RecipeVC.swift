//
//  RecipeVC.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 24.12.2020.
//

import UIKit

class RecipeVC: UITableViewController {

    var didUpdateModel: ((_ model: Recipe) -> ())?

    var model: Recipe? {
        didSet {
            navigationItem.title = model?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = .clear // чтобы не было видно разделителей внутри ячейки
        view.backgroundColor = .white
        
        // регистрирую ячейки
        tableView.register(RecipeHeaderCell.self, forCellReuseIdentifier: "RecipeHeaderCell")
        tableView.register(RecipePictureCell.self, forCellReuseIdentifier: "RecipePictureCell")
        tableView.register(RecipeShortTextCell.self, forCellReuseIdentifier: "RecipeShortTextCell")
        tableView.register(RecipeVideoCell.self, forCellReuseIdentifier: "RecipeVideoCell")
        tableView.register(RecipeInstructionCell.self, forCellReuseIdentifier: "RecipeInstructionCell")
        tableView.register(RecipeFooterCell.self, forCellReuseIdentifier: "RecipeFooterCell")
        

    }
    
// надо все равно, тк без секций не работает
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
    
 // ячейка -- это информационный блок
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 6
   }
    
 // заполняем содержимым ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0: // заголовок
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeHeaderCell", for: indexPath) as? RecipeHeaderCell else { return UITableViewCell() }
            cell.model = model
            cell.didUpdateModel = { [weak self] (model) in
                self?.model = model
                self?.didUpdateModel?(model)
            }
            return cell
        case 1: // картинка
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipePictureCell", for: indexPath) as? RecipePictureCell else { return UITableViewCell() }
            cell.model = model
            return cell
        case 2: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeShortTextCell", for: indexPath) as? RecipeShortTextCell else { return UITableViewCell() }
            cell.model = model
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeVideoCell", for: indexPath) as? RecipeVideoCell else { return UITableViewCell() }
            cell.model = model
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInstructionCell", for: indexPath) as? RecipeInstructionCell else { return UITableViewCell() }
            cell.model = model
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeFooterCell", for: indexPath) as? RecipeFooterCell else { return UITableViewCell() }
            return cell
        default: return UITableViewCell()
        }
    }


}
