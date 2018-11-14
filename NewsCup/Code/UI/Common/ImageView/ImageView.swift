//
//  ImageView.swift
//  Guardian
//
//  Created by Ravindra Soni on 18/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

open class ImageView: UIImageView {
    
    let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var downloadImageCompletion: SDCacheQueryCompletedBlock?
    public typealias ImageDownloadCompletionBlock = (_ success: Bool) -> Void
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.activity)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.activity.frame = self.bounds
    }
    
    open func setImageFromUrl(_ urlString: String,
                              placeHolder: UIImage? = nil,
                              completion: ImageDownloadCompletionBlock? = nil) {
        let url = URL(string: urlString)
        
        let options: SDWebImageOptions = [
            .continueInBackground,
            .highPriority,
            .retryFailed
        ]
        
        self.image = placeHolder
        self.startLoader()
        
        self.sd_setImage(with: url,
                         placeholderImage: placeHolder,
                         options: options) { [weak self] (image, _, cacheType, _) in
                
            guard let this = self else { return }
            if completion != nil { completion?(true) }
            
            if cacheType == .none {
                this.alpha = 0
                UIView.animate(withDuration: 0.5) { this.alpha = 1 }
            }
            
            this.stopLoader()
        }
    }
    
    private func startLoader() {
        self.activity.isHidden = false
        self.activity.startAnimating()
    }
    
    private func stopLoader() {
        self.activity.isHidden = true
        self.activity.stopAnimating()
    }
}
