//
//  Date+JSON.swift
//  Model
//
//  Created by kartic on 05/02/18.
//  Copyright © 2018 NickelFox. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing

public protocol JSONParseFormatTransformable: JSONParseable {
    
    associatedtype RawValue: JSONParseable
    
    static func transform(_ value: RawValue, format: String) -> Self?
    
}

extension JSONParseFormatTransformable {
    
    public static func parse(_ json: JSON, format: String) throws -> Self {
        do {
            let rawValue = try RawValue.parse(json)
            if let transformedValue = Self.transform(rawValue, format: format) {
                return transformedValue
            } else {
                throw JSONError.invalidTransform(
                    json: json,
                    fromType: String(describing: RawValue.self),
                    toType: String(describing: Self.self))
            }
        } catch {
            throw error
        }
    }
    
}


extension Date: JSONParseTransformable {
    
    public typealias RawValue = String
    
    public static func transform(_ value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.date(from:value)
    }
    
}

extension Date: JSONParseFormatTransformable {
    
    public static func transform(_ value: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from:value)
    }
    
}

