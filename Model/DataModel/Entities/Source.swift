
//
//  Source.swift
//  Model
//
//  Created by Abhishek Thapliyal on 22/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

public struct Source: JSONParseable {
    
    public var id: String
    public var name: String
    public var url: String
    public var category: String
    public var desc: String
    public var language: String
    public var country: String
    
    public static func parse(_ json: JSON) throws -> Source {
        return try Source(id: json["id"]^,
                          name: json["name"]^,
                          url: json["url"]^,
                          category: json["category"]^,
                          desc: json["description"]^,
                          language: json["language"]^,
                          country: json["country"]^)
    }
    
}
