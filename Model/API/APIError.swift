//
//  APIError.swift
//  Model
//
//  Created by Ravindra Soni on 10/03/18.
//  Copyright © 2018 NickelFox. All rights reserved.
//

import AnyErrorKit

public enum APIError: AnyError {
	case transactionFailed
	
	public var code: Int { return 0 }
	public var domain: String { return "API Error" }
	public var message: String {
		switch self {
		case .transactionFailed: return "Transaction failed. Please tray again."
		}
	}
}
