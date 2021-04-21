//
//  RecipeVideoCell.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 24.12.2020.
//

import UIKit
import WebKit

class RecipeVideoCell: UITableViewCell {

    //обработка значений после того, как модель придет в ячейку вместе с данными
    var model: ModelRecipe? {
        didSet {
            guard let videoURL = model?.videoURL else { return } // не будем грузить видео, если ничего нет
            loadVideo(videoURL)
        }
    }
    
    // загружает видео в вебвью (встроенный в приложение браузер).Часть адреса "playsinline=1" -- это значит мы говорим ютубу убрать все лишнее, чтобы был только просмотр видео
    func loadVideo(_ url: String) {
        guard let myURL = URL(string: "\(url)?playsinline=1") else { return }
        let youtubeRequest = URLRequest(url: myURL)
        webview.load(youtubeRequest)
    }
    
    lazy var webview: WKWebView = {
        let webViewConfiguration = WKWebViewConfiguration() // создается конфигурация для вебвью со значениями по умолчанию
        webViewConfiguration.allowsInlineMediaPlayback = true // разрешаем воспроизведение встроенного в страницу мультимедиа
        let wkWebView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        wkWebView.scrollView.isScrollEnabled = false // запрет скроллить внутри видео (чтобы скролл был общий)
        return wkWebView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none // чтобы не подсвечивалось серым при нажатии
        self.contentView.addSubview(webview)
        
        webview.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalToSuperview().offset(8)
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.right.equalToSuperview().offset(-8)
            constraint.height.equalTo(250)

        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
