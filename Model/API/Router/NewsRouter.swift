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
    case topHeadlines(page: Int,
                      pageSize: Int,
                      searchQuery: String?,
                      categories: [String],
                      countries: [String])
    
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
            return "/v2/everything"
        case .sources:
            return "/v2/sources"
        case .topHeadlines:
            return "/v2/top-headlines"
        }
    }
    
    public var params: [String: Any] {
        var params: [String: Any] = ["apiKey": APIConfig.APIKey]
        switch self {
        case .everything(let query):
            params["q"] = query
        case .sources(let query):
            params["q"] = query
        case .topHeadlines(let page,
                           let pageSize,
                           let searchQuery,
                           let categories,
                           let countries):
            params["page"] = page
            params["pageSize"] = pageSize
            
            if !categories.isEmpty {
                params["categories"] = categories.joined(separator: ",")
            }
            
            if !countries.isEmpty {
                params["countries"] = countries.joined(separator: ",")
            }
            
            if let searchQuery = searchQuery {
                params["q"] = searchQuery
            }
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
