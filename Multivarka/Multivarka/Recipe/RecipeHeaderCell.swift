//
//  RecipeHeaderCell.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 24.12.2020.
//

import UIKit

class RecipeHeaderCell: UITableViewCell {

//обработка значений после того, как модель придет в ячейку вместе с данными
   var model: ModelRecipe? {
       didSet {
        authorNameLabel.text = model?.authorName
        dateLabel.text = model?.date
        durationLabel.text = model?.duration
        portionsLabel.text = "\(model?.portions ?? 0)"
        likesLabel.text = "\(model?.likes ?? 0)"
        favoritesButton.isSelected = model?.isFavorite ?? false
        }
    }
    
    // обновленное состояние модели (чтобы сохранять нажатое состояние кнопки добавления в Избранное)
    var didUpdateModel: ((_ model: ModelRecipe) -> ())?
    
    lazy var authorImage: UIImageView = {
        let l = UIImageView()
        l.image = UIImage(named: "author")
        l.contentMode = .scaleAspectFit
        return l
    }()
    
    lazy var authorLabel: UILabel = {
        let l = UILabel()
        l.text = "Добавил:"
        l.font = .systemFont(ofSize: 11)
        return l
    }()
    
    lazy var authorNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        return l
    }()
    
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        return l
    }()
    
    lazy var durationImage: UIImageView = {
        let l = UIImageView()
        l.image = UIImage(named: "duration")
        l.contentMode = .scaleAspectFit
        return l
    }()
    
    lazy var durationLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        return l
    }()
    
    lazy var portionsImage: UIImageView = {
        let l = UIImageView()
        l.image = UIImage(named: "portions")
        return l
    }()
    
    lazy var portionsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        return l
    }()
    
    lazy var likeButton: UIButton = {
        let l = UIButton()
        l.setBackgroundImage(UIImage(named: "like"), for: .normal)
        l.addTarget(self, action: #selector(likesClicked), for: .touchUpInside)
        return l
    }()
    
    lazy var likesBackground: UIImageView = {
        let l = UIImageView()
        l.image = UIImage(named: "likes_background")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 10))
        return l
    }()
    
    lazy var likesLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        l.textColor = .red
        return l
    }()
    
    lazy var favoritesButton: UIButton = {
        let l = UIButton()
        l.setBackgroundImage(UIImage(named: "favorites_border")?.withRenderingMode(.alwaysTemplate), for: .normal)
        l.setBackgroundImage(UIImage(named: "favorites")?.withRenderingMode(.alwaysTemplate), for: .selected)
        l.tintColor = UIColor(red: 0.7, green: 0, blue: 0.1, alpha: 1.0)
        l.addTarget(self, action: #selector(favoritesClicked), for: .touchUpInside)
        return l
    }()
    
    @objc func favoritesClicked() {
        model?.isFavorite = !(model?.isFavorite ?? false)
        favoritesButton.isSelected = model?.isFavorite ?? false
        if let model = model {
            didUpdateModel?(model)
        }
    }
    
    @objc func likesClicked() {
        model?.likes = (model?.likes ?? 0) + 1
        likesLabel.text = "\(model?.likes ?? 0)"
        if let model = model {
            didUpdateModel?(model)
        }
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none // чтобы не подсвечивалось серым при нажатии
        self.contentView.addSubview(authorImage)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(authorNameLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(durationImage)
        self.contentView.addSubview(durationLabel)
        self.contentView.addSubview(portionsImage)
        self.contentView.addSubview(portionsLabel)
        self.contentView.addSubview(likeButton)
        self.contentView.addSubview(likesBackground)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(favoritesButton)
        

        authorImage.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalToSuperview().offset(8)
            constraint.height.equalTo(13)
            constraint.width.equalTo(13)
        }
        authorLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalTo(authorImage.snp.right).offset(2)
        }
        authorNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalTo(authorLabel.snp.right).offset(3)
        }
        dateLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalTo(authorNameLabel.snp.right).offset(10)
        }
        durationImage.snp.makeConstraints { (constraint) in
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.top.equalTo(authorImage.snp.bottom).offset(8)
            constraint.left.equalToSuperview().offset(8)
            constraint.width.equalTo(13)
            constraint.height.equalTo(13)
        }
        durationLabel.snp.makeConstraints { (constraint) in
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.top.equalTo(authorImage.snp.bottom).offset(8)
            constraint.left.equalTo(durationImage.snp.right).offset(3)
        }
        portionsImage.snp.makeConstraints { (constraint) in
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.top.equalTo(authorImage.snp.bottom).offset(8)
            constraint.left.equalTo(durationLabel.snp.right).offset(10)
        }
        portionsLabel.snp.makeConstraints { (constraint) in
            constraint.bottom.equalToSuperview().offset(-8)
            constraint.top.equalTo(authorImage.snp.bottom).offset(8)
            constraint.left.equalTo(portionsImage.snp.right).offset(3)
        }
        likeButton.snp.makeConstraints { (constraint) in
            constraint.centerY.equalToSuperview()
            constraint.right.equalToSuperview().offset(-8)
            constraint.width.equalTo(31)
            constraint.height.equalTo(31)
        }
        likesBackground.snp.makeConstraints { (constraint) in
            constraint.centerY.equalToSuperview()
            constraint.right.equalTo(likeButton.snp.left).offset(-3)
            constraint.height.equalTo(31)
            constraint.left.equalTo(likesLabel.snp.left).offset(-4)
        }
        likesLabel.snp.makeConstraints { (constraint) in
            constraint.centerY.equalToSuperview()
            constraint.right.equalTo(likeButton.snp.left).offset(-13)
        }
        favoritesButton.snp.makeConstraints { (constraint) in
            constraint.centerY.equalToSuperview()
            constraint.right.equalTo(likesLabel.snp.left).offset(-13)
            constraint.height.equalTo(31)
            constraint.width.equalTo(31)
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
