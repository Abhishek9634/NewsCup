//
//  UIView+Slider.swift
//  SLide
//
//  Created by Abhishek Thapliyal on 25/10/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

@IBDesignable
class SliderGraph: UIView {
    
    let sliderView: UIView = UIView()
    
    @IBInspectable var sliderColor: UIColor = .blue {
        didSet {
            self.sliderView.backgroundColor = self.sliderColor
        }
    }
    
    @IBInspectable var sliderBGColor: UIColor = .lightGray {
        didSet {
            self.backgroundColor = self.sliderBGColor
        }
    }
    
    @IBInspectable var minValue: CGFloat = 0.0
    @IBInspectable var maxValue: CGFloat = 100.0
    @IBInspectable var sliderValue: CGFloat = 0.0
    
    override func awakeFromNib() {
        self.addSubview(self.sliderView)        
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    }
    
    private func updateSlider() {
        let sliderWidth = self.bounds.width * (self.sliderValue / self.maxValue)
        self.sliderView.frame = CGRect(x: self.bounds.origin.x,
                                       y: self.bounds.origin.y,
                                       width: sliderWidth,
                                       height: self.bounds.height)
    }
    
    override func layoutSubviews() {
        self.updateSlider()
    }
}
