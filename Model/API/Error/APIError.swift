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
	
	public var code: Int { return 0 }
	public var domain: String { return "API Error" }
	public var message: String {
		switch self {
		case .unknown:
            return "Something went wrong. Please tray again."
        case .custom(let message):
            return message
		}
	}
}
