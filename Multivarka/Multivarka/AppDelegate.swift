//
//  AppDelegate.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 18.12.2020.
//

import UIKit

@UIApplicationMain // макрос для получения функции main (чтобы приложение запускалось. По умолчанию должно быть)

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    var sideBar: SideBarVC?
    var recipeListVC: RecipeListVC?
    var categoriesModel: CategoriesModel?
    
    func showMenuController(menuItem: MenuVC.MenuItem) {
        sideBar?.hideMenu() // чтоб меню скрывалось после выбора пункта
        switch menuItem {
        case .home:
            navController?.popToRootViewController(animated: true)
        case .favorites:
            let vc = RecipeListVC()
            vc.model = recipeListVC?.model
            vc.showOnlyFavorites = true
            vc.title = "Избранное"
            navController?.pushViewController(vc, animated: true)
        case .recommend:
            // чтобы снизу выплывал блок для поделиться ссылкой на приложение
            let url = URL(string: "https://pro-multivarka.ru/")
            let activity = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
            navController?.present(activity, animated: true, completion: nil)
        case .authorize:
            navController?.pushViewController(UIViewController(), animated: true)
        case .about:
            // получаем url локального файла в бандле приложения
            if let url = Bundle.main.url(forResource: "about", withExtension: "html") {
                let vc = WebVC()
                vc.title = "О приложении"
                vc.url = url // передаем содержимое url во вью контроллер
                navController?.pushViewController(vc, animated: true)
            }
        case .terms:
            if let url = Bundle.main.url(forResource: "policy", withExtension: "html") {
                let vc = WebVC()
                vc.title = "Политика приложения"
                vc.url = url // передаем содержимое url во вью контроллер
                navController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sideBar = SideBarVC()
        recipeListVC = RecipeListVC()
        recipeListVC?.title = "Главная"

        recipeListVC?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: sideBar, action: #selector(sideBar?.touchOnHamburger(_:)))
        recipeListVC?.model = RecipeListModel()
        self.navController = UINavigationController(rootViewController: recipeListVC!)
        self.navController?.navigationBar.barTintColor = UIColor(red: 0.7, green: 0, blue: 0.1, alpha: 1.0)
        self.navController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navController?.navigationBar.tintColor = .white
        
        let menu = MenuVC()
        menu.view.backgroundColor = .white
        sideBar?.navigation = self.navController
        sideBar?.menu = menu
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = sideBar
        self.window?.backgroundColor = UIColor.white
        
        // для парсинга html с сайта (в Categories.Model)
        /*categoriesModel = CategoriesModel()
        categoriesModel?.getCategories()*/
        
        return true
    }
    
    

}

