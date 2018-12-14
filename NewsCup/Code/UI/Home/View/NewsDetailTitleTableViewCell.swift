//
//  NewsDetailTitleTableViewCell.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 14/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

struct NewsDetailTitleCellModel {
    var title: String
    var date: String
    var source: String
    var imageUrl: String
}

class NewsDetailTitleTableViewCell: TableViewCell {

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
        guard let model = item as? NewsDetailTitleCellModel else { return }
        self.titleLabel.text = model.title
        self.dateLabel.text = model.date
        self.sourceLabel.text = model.source
        self.imgView.setImageFromUrl(model.imageUrl)
    }
}
