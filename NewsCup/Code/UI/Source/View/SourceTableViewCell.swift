//
//  SourceTableViewCell.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 22/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import UIKit
import Model

class SourceTableViewCell: TableViewCell {

    @IBOutlet weak var imgView: ImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? Source else { return }
        self.imgView.setImageFromUrl(model.url)
        self.titleLabel.text = model.name
    }
    
}
