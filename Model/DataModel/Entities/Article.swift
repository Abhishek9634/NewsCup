//
//  Article.swift
//  Model
//
//  Created by Abhishek Thapliyal on 12/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

public struct Article: JSONParseable {
    
    public var sourceName: String
    public var author: String
    public var title: String
    public var desc: String
    public var url: String
    public var imageUrl: String
    public var publishedAt: String
    public var content: String
    
    
    public static func parse(_ json: JSON) throws -> Article {
        return Article(sourceName: json["source"]["name"]^!,
                       author: json["author"]^!,
                       title: json["title"]^!,
                       desc: json["description"]^!,
                       url: json["url"]^!,
                       imageUrl: json["urlToImage"]^!,
                       publishedAt: json["publishedAt"]^!,
                       content: json["content"]^!)
    }
    
}
