//
//  NewsRouter.swift
//  Model
//
//  Created by Abhishek Thapliyal on 14/11/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public enum NewsRouter: BaseRouter {
    
    case everything(query: String)
    case sources(query: String)
    case topHeadlines(query: String)
    
    public var method: HTTPMethod {
        switch self {
        case .everything,
             .sources,
             .topHeadlines:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .everything:
            return ""
        case .sources:
            return ""
        case .topHeadlines:
            return ""
        }
    }
    
    public var params: [String: Any] {
        var params: [String: Any] = ["API_KEY": APIConfig.APIKey]
        switch self {
        case .everything(let query):
            params["q"] = ""
        case .sources:
            params["q"] = ""
        case .topHeadlines:
            params["q"] = ""
        }
        return params
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    public var keypathToMap: String? {
        return nil
    }
}
