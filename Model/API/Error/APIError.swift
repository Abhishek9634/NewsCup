//
//  APIError.swift
//  Model
//
//  Created by Ravindra Soni on 10/03/18.
//  Copyright © 2018 NickelFox. All rights reserved.
//

import AnyErrorKit

public enum APIError: AnyError {
	
    case unknown
    case custom(message: String)
    case customError(error: AnyError)
	
	public var code: Int {
        switch self {
        case .customError(let error):
            return error.code
        default:
            return 0
        }
    }
    
    public var domain: String {
        switch self {
        case .customError(let error):
            return error.domain
        default:
            return "API Error"
        }
    }
    
	public var message: String {
        switch self {
        case .customError(let error):
            return error.domain
        case .custom(let message):
            return message
        default:
            return "Something went wrong. Please tray again."
        }
	}
    
}
