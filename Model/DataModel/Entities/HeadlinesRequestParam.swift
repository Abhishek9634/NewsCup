//
//  HeadlinesRequestParam.swift
//  Model
//
//  Created by Abhishek Thapliyal on 12/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

public struct Country: JSONParseable {
    
    public var name: String
    public var code: String
    
    public static func parse(_ json: JSON) throws -> Country {
        return try Country(name: json["name"]^,
                           code: json["code"]^)
    }
}

public struct HeadlinesRequestParam: JSONParseable {
    
    public var categories: [String]
    public var countries: [Country]
    
    public static func parse(_ json: JSON) throws -> HeadlinesRequestParam {
        return try HeadlinesRequestParam(categories: json["categories"]^^,
                                         countries: json["countries"]^^)
    }
}
