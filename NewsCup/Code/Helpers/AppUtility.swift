//
//  AppUtility.swift
//  Guardian
//
//  Created by Ravindra Soni on 18/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation

struct AppUtility {
	static var appVersion: String {
		return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
	}
}

struct Crashlytics {
    static let appId = "e11f76cb54c94cbb8a3c457bce73f140"
}
