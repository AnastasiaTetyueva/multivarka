//
//  MenuVC.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 03.01.2021.
//

import UIKit

class MenuVC: UITableViewController {

    //  тип
    enum MenuItem {
        case home
        case favorites
        case recommend
        case authorize
        case about
        case terms
        
        func title() -> String {
            switch self {
            case .home:
                return "Главная"
            case .favorites:
                return "Избранное"
            case .recommend:
                return "Порекомендовать"
            case .authorize:
                return "Войти"
            case .about:
                return "О приложении"
            case .terms:
                return "Политика"
            }
        }
        
        func icon() -> String {
            switch self {
            case .home:
                return "home"
                return "categories"
            case .favorites:
                return "favorites_border"
            case .recommend:
                return "share"
            case .authorize:
                return "authorize"
            case .about:
                return "about"
            case .terms:
                return "policy"
            }
        }    }
    
    let menu: [MenuItem] = [.home, .favorites, .recommend, .authorize, .about, .terms]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        let headerView = UIImageView(image: UIImage(named: "multivarka"))
        headerView.contentMode = .scaleAspectFit
        tableView.tableHeaderView = headerView

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? MenuCell else { return UITableViewCell() }

        let menuItem = menu[indexPath.row]
        cell.model = menuItem
        return cell
    }
    
    // взывается, когда тыкают на пункт меню, тк переход на другие контроллеры описаны в AppDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return } // получаем ссылку на AppDelegate
        appDelegate.showMenuController(menuItem: menu[indexPath.row])
    }
    
    // вызывается каждый раз, когда надо определить размеры, и мы в ней выставляем вертикальный размер заголовка меню
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = tableView.tableHeaderView {

            let height = CGFloat(100.0)

            var headerFrame = headerView.frame
            if height != headerFrame.size.height {
                // сначала приводим к нужному размеру фрейм
                headerFrame.size.height = height
                // присваеваем
                headerView.frame = headerFrame
                // заставляем таблицу обновить заголовок
                tableView.tableHeaderView = headerView
            }
        }
    }
    
}
