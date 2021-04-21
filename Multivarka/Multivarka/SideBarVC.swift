//
//  SideBarVC.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 02.01.2021.
//

import UIKit

// SideBar управляет контроллером меню (MenuVC)

class SideBarVC: UIViewController {

    // SideBar в себя включает контроллеры navigation и menu
    
    var menu: UIViewController?
    var navigation: UINavigationController?
    var isMenuVisible: Bool = false // по умолчанию
    let MENUWIDTH = 200.0 // ширина меню
    
    lazy var shadow: UIControl = {
        let l = UIControl() // кнопка, но без визуальных элементов. Вью, которая может реагировать на прикосновения
        l.backgroundColor = .black
        l.alpha = 0 // черная, но прозрачная
        l.isHidden = true
        l.addTarget(self, action: #selector(touchOnShadow(_:)), for: .touchUpInside)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let ctl = navigation {
            view.addSubview(ctl.view) // ctl.view -- потому что addSubview добавляет только вью
            addChild(ctl) // для того, чтобы этот контроллер передавал вышележащему контролеру события
        } // кладем в правильном порядке: первым тот, который ниже
        if let ctl = menu {
            view.addSubview(ctl.view)
        }
        view.addSubview(shadow)
    }
    
    // вызывается, когда вью контроллеру нужно, чтобы он сам определял координаты вьшек
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigation?.view.frame = view.bounds // чтобы наружный прямоугольник навконтроллера был равен прямоугольнику SideBar
        let height = Double(view.bounds.height)
        let width = Double(view.bounds.width)
    // координаты меню, когда оно выползает, и когда оно схлапывается
        if isMenuVisible {
            menu?.view.frame = CGRect(x: 0.0, y: 0.0, width: MENUWIDTH, height: height)
            shadow.frame = CGRect(x: MENUWIDTH, y: 0.0, width: width - MENUWIDTH, height: height)
        } else {
            menu?.view.frame = CGRect(x: -MENUWIDTH, y: 0.0, width: MENUWIDTH, height: height)
            shadow.frame = view.bounds
        }
    }
    
    // показать меню
    func showMenu() {
        guard !isMenuVisible else { return } // если меню уже показано, то выйти
        isMenuVisible = true
        shadow.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.shadow.alpha = 0.2 // self -- потому что внутри замыкания
            self.viewDidLayoutSubviews()
        }
    }
    
    // скрыть меню
    func hideMenu() {
        guard isMenuVisible else { return } // если меню уже скрыто, то выйти
        isMenuVisible = false
        // нужно скрыть уже после того, как анимация выполнится
        UIView.animate(withDuration: 0.3, animations: {
            self.viewDidLayoutSubviews()
            self.shadow.alpha = 0.0
        }) { (_) in
            self.shadow.isHidden = true // completion вызывается, когда уже анимации закончились
        }
    }
    
    // нажатие на тень (отработка нажатия на контрол скрывания меню)
    // @objc -- для того, чтобы функция стала селектором
    @objc func touchOnShadow(_ control: UIControl) {
        hideMenu()
    }
    
    // нажатие на гамбургер (отработка нажатия)
    @objc func touchOnHamburger(_ control: UIBarButtonItem) {
        showMenu()
    }
    
}
