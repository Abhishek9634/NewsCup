//
//  FilterAttributeTableViewCell.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 13/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class FilterAttributeTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func configure(_ item: Any?) {
        guard let model = item as? FilterModel else { return }
        self.titleLabel.text = model.attribute
        self.titleLabel.textColor = model.isSelected ? .blue : .black
    }
}
