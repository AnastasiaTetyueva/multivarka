//
//  RecipePictureCell.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 24.12.2020.
//

import UIKit

class RecipePictureCell: UITableViewCell {

    //обработка значений после того, как модель придет в ячейку вместе с данными
    var model: Recipe? {
        didSet {
            if let image = model?.image, let imageURL = URL(string: image) {
                picture.loadImage(url: imageURL)
            }
        }
    }
    
    lazy var picture: UIImageView = {
        let l = UIImageView()
        l.contentMode = .scaleAspectFill
        l.clipsToBounds = true
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none // чтобы не подсвечивалось серым при нажатии
        self.contentView.addSubview(picture)
        
        picture.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalToSuperview().offset(8)
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.height.equalTo(200)
            constraint.right.equalToSuperview().offset(-8)
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
