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
    
    public var method: HTTPMethod {
        switch self {
        case .fetchSources:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .fetchSources:
            return "/v2/sources"
        }
    }
    
    public var params: [String: Any] {
        var params: [String: Any] = ["apiKey": APIConfig.APIKey]
        switch self {
        case .fetchSources:
            break
        }
        return params
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    public var keypathToMap: String? {
        switch self {
        default:
            return nil
        }
    }
}
