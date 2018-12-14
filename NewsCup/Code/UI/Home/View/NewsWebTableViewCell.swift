//
//  NewsWebTableViewCell.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 14/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

struct NewsWebCellModel {
    var webUrl: String
}

protocol NewsWebTableViewCellDelegate: class {
    func handleWebAction(_ cell: NewsWebTableViewCell, url: String)
}

class NewsWebTableViewCell: TableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func webAction(_ sender: UIButton) {
        guard let model = self.item as? NewsWebCellModel else { return }
        (self.delegate as? NewsWebTableViewCellDelegate)?.handleWebAction(self, url: model.webUrl)
    }
}
