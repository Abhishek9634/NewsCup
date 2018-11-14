//
//  String+Helper.swift
//  Guardian
//
//  Created by Abhishek Thapliyal on 5/23/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    convenience init?(htmlString: String, font: UIFont, colorCode: String) {
        let styledHTMLString = "<span style=\"font-family:\(font.fontName); color:\(colorCode) ;font-size:\(font.pointSize)px\">\(htmlString)</span>"
        guard let data = styledHTMLString.data(using: String.Encoding.utf8) else { return nil }
        do {
            try self.init(data: data,
                          options: [.documentType: NSAttributedString.DocumentType.html,
                                    .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)],
                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
}

extension String {
    
    func isEmptyHTMLContent() -> Bool {
        var r = Range(self.startIndex..<self.endIndex)
        var str = self.copy() as! String
        while let range = str.range(of: "<[^>]+>", options: .regularExpression) {
            r = range
            str = str.replacingCharacters(in: r, with: "")
        }
        
        str = str.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return str.isEmpty
    }
}
