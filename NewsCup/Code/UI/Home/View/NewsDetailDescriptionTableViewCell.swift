//
//  NewsDetailDescriptionTableViewCell.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 14/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

struct NewsDetailDescriptionCellModel {
    var title: String
    var content: String
}

class NewsDetailDescriptionTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func configure(_ item: Any?) {
        guard let model = item as? NewsDetailDescriptionCellModel else { return }
        self.titleLabel.text = model.title
        self.contentLabel.text = model.content
    }
}
