//
//  NewsCupAPIClient.swift
//  Model
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

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

