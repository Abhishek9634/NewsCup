//
//  TopNewsCellModel.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 13/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model

struct TopNewsCellModel {
    
    var article: Article
    var date: String = ""
    
    init(article: Article) {
        self.article = article
        self.date = self.parseDate(publishedAt: article.publishedAt)
    }
    
    private func parseDate(publishedAt: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(
            from: publishedAt
        ) else {
            return ""
        }
        
        dateFormatter.dateFormat = "d MMM yyyy h:mm a"
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: date)
//        print("EXACT_DATE : \(dateString)")
        return dateString
    }
}
