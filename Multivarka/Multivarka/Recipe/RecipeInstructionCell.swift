//
//  RecipeInstructionCell.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 24.12.2020.
//

import UIKit

class RecipeInstructionCell: UITableViewCell {

    //обработка значений после того, как модель придет в ячейку вместе с данными
    var model: ModelRecipe? {
        didSet {
            instruction.text = model?.text
        }
    }
    
    lazy var instruction: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0 // ограничение по количеству строк = без ограничений
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none // чтобы не подсвечивалось серым при нажатии
        self.contentView.addSubview(instruction)
        
        instruction.snp.makeConstraints { (constraint) in
            constraint.top.equalToSuperview().offset(8)
            constraint.left.equalToSuperview().offset(8)
            constraint.bottom.equalToSuperview().offset(-8)
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
