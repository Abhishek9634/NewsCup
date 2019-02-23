//
//  SourceRouter.swift
//  Model
//
//  Created by Abhishek Thapliyal on 22/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public enum SourceRouter: BaseRouter {
    
    case fetchSources
    case sourceTopHeadlines(source: String,
        page: Int,
        pageSize: Int)
    
    public var method: HTTPMethod {
        switch self {
        case .fetchSources, .sourceTopHeadlines:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .fetchSources:
            return "/v2/sources"
        case .sourceTopHeadlines:
            return "/v2/top-headlines"
        }
    }
    
    public var params: [String: Any] {
        var params: [String: Any] = ["apiKey": APIConfig.APIKey]
        switch self {
        case .fetchSources:
            break
        case .sourceTopHeadlines(let source,
                                 let page,
                                 let pageSize):
            params["page"] = page
            params["pageSize"] = pageSize
            params["sources"] = source
        }
        return params
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    public var keypathToMap: String? {
        switch self {
        case .fetchSources:
            return "sources"
        case .sourceTopHeadlines:
            return "articles"
        }
    }
}
