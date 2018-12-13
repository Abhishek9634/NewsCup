//
//  NewsCupAPIClient.swift
//  Model
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing

public let DefaultPageSize = 20

class NewsCupAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    
    static let shared = NewsCupAPIClient()
    
    override init() {
        super.init()
        self.enableLogs = true
    }
	
	override func clearAuthHeaders() {
		self.authHeaders = AuthHeaders(sessionToken: "")
	}
	
	override func authenticationHeaders(response: HTTPURLResponse) -> AuthHeaders? {
		return self.authHeaders
	}
}

extension NewsCupAPIClient {
    
    public func requestOffline<T: JSONParseable>(jsonfileName: String,
                                                 completion: @escaping (_ result: APIResult<T>) -> Void) {
        
        guard let filePath = Bundle.main.url(forResource: jsonfileName,
                                             withExtension: "json") else {
            completion(.failure(APIError.custom(message: "File Not Found")))
            return
        }
        
        do {
            let data = try Data.init(contentsOf: filePath)
            let json = try JSON(data: data)
            let result = try T.parse(json)
            completion(.success(result))
        } catch let error as AnyError {
            completion(.failure(error))
        } catch {
            completion(.failure(APIError.custom(message: "Error while reading file")))
        }
    }
    
}
