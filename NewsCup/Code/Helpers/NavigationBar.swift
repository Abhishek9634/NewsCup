//
//  NavigationBar.swift
//  Guardian
//
//  Created by Ravindra Soni on 18/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation
import FLUtilities

private let backImage: UIImage? = nil

class NavigationBar: UINavigationBar {
	
	override func awakeFromNib() {
		super.awakeFromNib()
        
        self.isTranslucent = false
		
        if let backImage = backImage {
			self.backIndicatorImage = backImage
			self.backIndicatorTransitionMaskImage = backImage
		}
        
        self.barTintColor = UIColor.guardianGray
        self.tintColor = UIColor.white
		self.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.avenirNextDemiBold(18.0),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
	}
    
    func setGradientBackground(colors: [UIColor]) {
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        self.setBackgroundImage(gradientLayer.gradientImage, for: UIBarMetrics.default)
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = colors.map { $0.cgColor }
        self.startPoint = CGPoint(x: 0, y: 1)
        self.endPoint = CGPoint(x: 1, y: 1)
    }
    
    var gradientImage: UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(self.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            self.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIViewController {
    
    func setNavigationGradient() {
        let colors: [UIColor] = [UIColor(hexString: "1EADD3"), UIColor(hexString: "1199BD")]
        (self.navigationController?.navigationBar as! NavigationBar).setGradientBackground(colors: colors)
    }
}
