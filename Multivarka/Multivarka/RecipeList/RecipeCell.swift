//
//  RecipeCell.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 18.12.2020.
//



// ЭТО ЯЧЕЙКА В СПИСКЕ РЕЦЕПТОВ. Тут весь контент

import UIKit
import SnapKit

class RecipeCell: UITableViewCell {

    //обработка значений после того, как модель придет в ячейку вместе с данными
    var model: ModelRecipe? {
        didSet {
            title.text = model?.name
            if let previewIcon = model?.previewIcon, let previewIconURL = URL(string: previewIcon) {
                icon.loadImage(url: previewIconURL)
            }
        }
    }
    
    lazy var title: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.black
        l.font = UIFont.boldSystemFont(ofSize: 16)
        return l
    }()
    
    lazy var icon: UIImageView = {
        let l = UIImageView()
        l.contentMode = .scaleAspectFill
        l.clipsToBounds = true
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none // чтобы не подсвечивалось серым при нажатии
        self.contentView.addSubview(title)
        self.contentView.addSubview(icon)
        
        title.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalTo(icon.snp.right).offset(8)
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.right.equalToSuperview().offset(-8)
        }
        
        icon.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalToSuperview().offset(8)
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.height.equalTo(80)
            constraint.width.equalTo(80)
        }
        
    }
    // автоматом добавляет Apple, когда ругается на вышестоящий инициализатор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // просто нужны эти две пустые функции
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
