//
//  Source+API.swift
//  Model
//
//  Created by Abhishek Thapliyal on 22/02/19.
//  Copyright © 2019 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import RxSwift

public extension Source {
    
    static func fetchSources(completion: @escaping APICompletion<ListResponse<Source>>) {
        let router = SourceRouter.fetchSources
        NewsCupAPIClient.shared.request(router, completion: completion)
    }
 
    static func sourceTopHeadlines(for source: String,
                                   page: Int = 0,
                                   pageSize: Int = DefaultPageSize,
                                   comletion: @escaping APICompletion<ListResponse<Article>>) {
        
        let router = SourceRouter.sourceTopHeadlines(source: source,
                                                     page: page,
                                                     pageSize: pageSize)
        NewsCupAPIClient.shared.request(router, completion: comletion)
    }
    
}

// RxSwift
public extension Source {
    
    static func fetchSources() -> Observable<[Source]> {
        return Observable<[Source]>.create { observer in
            let router = SourceRouter.fetchSources
            NewsCupAPIClient.shared.request(router, completion: { (result: APIResult<ListResponse<Source>>) in
                switch result {
                case .success(let response):
                    observer.onNext(response.list)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}
