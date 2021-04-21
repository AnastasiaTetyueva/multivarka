//
//  WebVC.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 13.01.2021.
//

import UIKit
import WebKit

// вью контроллер для показа разделов About и Policy в формате html. Мы создаем здесь свой браузер

class WebVC: UIViewController {

    var url: URL?
    
    lazy var webview: WKWebView = {
        let webViewConfiguration = WKWebViewConfiguration() // создается конфигурация для вебвью со значениями по умолчанию
        webViewConfiguration.allowsInlineMediaPlayback = true // разрешаем воспроизведение встроенного в страницу мультимедиа
        let wkWebView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        wkWebView.scrollView.isScrollEnabled = true // здесь вебвью будет на весь экран, поэтому должно быть можно скроллить
        return wkWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else { return } // проверка, что url не null, тк переменная опциональная
        let request = URLRequest(url: url) // создание объекта, открывающего ресурс
        webview.load(request)
        
    }
    
    // стандартная функция для создания вью (обычно по умолчанию во вью контроллере создается UIView, а нам сейчас нужен WKWebView)
    override func loadView() {
        view = webview
    }
   

}
