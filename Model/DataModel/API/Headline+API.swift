//
//  Headline+API.swift
//  Model
//
//  Created by Abhishek Thapliyal on 12/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation

public struct Headline {
    
}

public extension Headline {
    
    static func fetchParams(completion: @escaping APICompletion<HeadlinesRequestParam>) {
        NewsCupAPIClient.shared.requestOffline(jsonfileName: "Headlines", completion: completion)
    }
    
}
