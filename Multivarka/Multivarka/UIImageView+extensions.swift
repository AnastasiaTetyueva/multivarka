//
//  UIImageView+extensions.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 19.12.2020.
//

import Foundation
import UIKit

// расширение UIImageView, чтобы в нем появилась новая функция
extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
