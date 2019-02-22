//
//  Source+API.swift
//  Model
//
//  Created by Abhishek Thapliyal on 22/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public extension Source {
    
    public static func fetchSources(completion: @escaping APICompletion<ListResponse<Source>>) {
        let router = SourceRouter.fetchSources
        NewsCupAPIClient.shared.request(router, completion: completion)
    }
    
}
