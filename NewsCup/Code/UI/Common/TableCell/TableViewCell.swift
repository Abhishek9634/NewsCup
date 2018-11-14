//
//  TableViewCell.swift
//  Guardian
//
//  Created by Ravindra Soni on 25/05/2016.
//  Copyright © 2016 NF. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

	var item: Any? {
		didSet {
			self.configure(self.item)
		}
	}

	weak var delegate: NSObjectProtocol? = nil

	func configure(_ item: Any?) {

	}

}


class TableHeaderFooterView: UITableViewHeaderFooterView {

	var item: Any? {
		didSet {
			self.configure(self.item)
		}
	}

	weak var delegate: NSObjectProtocol? = nil

	func configure(_ item: Any?) {

	}
	
}

