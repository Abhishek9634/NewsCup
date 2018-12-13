//
//  Headline+API.swift
//  Model
//
//  Created by Abhishek Thapliyal on 12/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public struct Headline {
    
}

public extension Headline {
    
    static func fetchParams(completion: @escaping APICompletion<HeadlinesRequestParam>) {
        NewsCupAPIClient.shared.requestOffline(jsonfileName: "Headlines", completion: completion)
    }
    
}

public extension Headline {
    
    static func fetchTopHeadlines(page: Int = 0,
                                  pageSize: Int = DefaultPageSize,
                                  searchQuery: String? = nil,
                                  categories: [String] = [],
                                  countries: [String] = [],
                                  comletion: @escaping APICompletion<ListResponse<Article>>) {
        
        let router = NewsRouter.topHeadlines(page: page,
                                             pageSize: pageSize,
                                             searchQuery: searchQuery,
                                             categories: categories,
                                             countries: countries)
        NewsCupAPIClient.shared.request(router, completion: comletion)
    }
    
}
