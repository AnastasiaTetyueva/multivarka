//
//  CategoriesModel.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 17.01.2021.
//

// скачивание и парсинг заглавной страницы сайта и получение оттуда иерархии категорий рецептов (для многоступенчатого меню), чтобы не пришлось писать бэкэнд. ПОКА НЕ ИСПОЛЬЗУЕТСЯ

import UIKit
import Fuzi // библиотека для парсинга html

class CategoriesModel {
    
    // асинхронно скачать содержимое файла; выполнить completion (завершение), передав ему результат скачивания в виде строки
    func fetchFile(_ urlString: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            do {
                let content = try String(contentsOf: url)
                DispatchQueue.main.async {
                    completion(content)
                }
            }
            catch {
                print(error.localizedDescription) // обработка исключений
            }
        }
    }
    
    // достать категории с сайта
    func getCategories() {
        fetchFile("https://pro-multivarka.ru/") { (content) in
// /html/body/div[1]/div/aside/nav/ul
            if let doc = try? XMLDocument(string: content) {
                for element in doc.xpath("//*[contains(@class, 'main-menu')]/node()") {
                  print("\(element.tag ?? ""): \(element.attributes)")
                }
            }
        }
    }
}
