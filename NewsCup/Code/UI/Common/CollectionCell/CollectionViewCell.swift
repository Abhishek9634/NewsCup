//
//  CollectionViewCell.swift
//  Guardian
//
//  Created by Ravindra Soni on 27/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

	var item: Any? {
		didSet {
			self.configure(self.item)
		}
	}
	
	weak var delegate: NSObjectProtocol? = nil
	
	func configure(_ item: Any?) {
		
	}
	
}

class CollectionReusableView: UICollectionReusableView {
	
	var item: Any? {
		didSet {
			self.configure(self.item)
		}
	}
	
	weak var delegate: NSObjectProtocol? = nil
	
	func configure(_ item: Any?) {
		
	}
	
}
