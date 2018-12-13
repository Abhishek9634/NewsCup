//
//  TopNewsTableViewCell.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 13/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class TopNewsTableViewCell: TableViewCell {

    @IBOutlet weak var imgView: ImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? TopNewsCellModel else { return }
        self.titleLabel.text = model.article.title
        self.sourceLabel.text = model.article.sourceName
        self.dateLabel.text = model.date
        self.imgView.setImageFromUrl(model.article.imageUrl)
    }
    
}
