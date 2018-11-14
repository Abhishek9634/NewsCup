////
////  TextField.swift
////  Guardian
////
////  Created by Abhishek Thapliyal on 06/02/18.
////  Copyright © 2018 NickelFox. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//private var kAssociationKeyMaxLength: Int = 0
//
//@IBDesignable
//class TextField: UITextField {
//    
//    let leftImageWidth: CGFloat = 20
//    let leftImageHeight: CGFloat = 15
//    let rightImagePadding: CGFloat = 5
//    
//    var leftImageUrl: String? {
//        didSet {
//            self.loadImage(from: leftImageUrl)
//        }
//    }
//    
//    @IBInspectable var leftImage: UIImage? {
//        didSet {
//            self.loadImage(image: leftImage)
//        }
//    }
//    
//    @IBInspectable var suffix: String? {
//        didSet {
//            self.updateSuffix()
//        }
//    }
//    
//    func loadImage(from url: String? = nil,
//                   image: UIImage? = nil) {
//        
//        let viewWidth = leftImageWidth + rightImagePadding
//        let renderPoint = CGPoint(x: 0, y: 0)
//        let view = UIView(frame: CGRect(origin: renderPoint,
//                                        size: CGSize(width: viewWidth,
//                                                     height: leftImageHeight)))
//        let imageView = ImageView(frame: CGRect(origin: renderPoint,
//                                                size: CGSize(width: leftImageWidth,
//                                                             height: leftImageHeight)))
//        
//        if let imageUrl = url {
//            leftViewMode = UITextFieldViewMode.always
//            imageView.setImageFromUrl(urlString: imageUrl)
//            imageView.contentMode = .scaleAspectFit
//            view.addSubview(imageView)
//            leftView = view
//        } else if let img = image {
//            leftViewMode = UITextFieldViewMode.always
//            imageView.image = img
//            imageView.contentMode = .scaleAspectFit
//            view.addSubview(imageView)
//            leftView = view
//        } else {
//            leftViewMode = UITextFieldViewMode.never
//            leftView = nil
//        }
//    }
//    
//    fileprivate func updateSuffix() {
//        if let text = suffix {
//            rightViewMode = UITextFieldViewMode.always
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
//            label.font = self.font
//            label.text = text
//            rightView = label
//        }
//    }
//
//    
//    @IBInspectable var maxLength: Int {
//        get {
//            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
//                return length
//            } else {
//                return Int.max
//            }
//        }
//        set {
//            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
//            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
//        }
//    }
//    
//    @objc func checkMaxLength(textField: UITextField) {
//        guard let prospectiveText = self.text, prospectiveText.count > maxLength else { return }
//        let selection = selectedTextRange
//        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex,
//                                                   offsetBy: maxLength)
//        let substring = prospectiveText[..<indexEndOfText]
//        text = String(substring)
//        selectedTextRange = selection
//    }
//}
