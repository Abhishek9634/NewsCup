//
//  AuthHeaders.swift
//  TemplateProject
//
//  Created by Ravindra Soni on 05/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing

public struct AuthHeaders: AuthHeadersProtocol {
    let sessionToken: String
    
    public static func parse(_ json: JSON) throws -> AuthHeaders {
        return try AuthHeaders(
            sessionToken: json[sessionTokenKey]^
        )
    }
    
    public func toJSON() -> [String: String] {
        let res: [String: String] = [
            sessionTokenKey: self.sessionToken
        ]
        return res
    }
    
    public var isValid: Bool {
        return !self.sessionToken.isEmpty
    }
    
}

extension AuthHeaders {
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

		urlRequest.setValue(self.sessionToken, forHTTPHeaderField: sessionTokenKey)
        return urlRequest
    }
}

private let sessionTokenKey = "Session-Token"
