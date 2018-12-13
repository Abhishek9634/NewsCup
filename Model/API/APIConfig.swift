//
//  APIConfig.swift
//  Model
//
//  Created by Abhishek Thapliyal on 2/1/18.
//  Copyright © 2018 NickelFox. All rights reserved.
//

import Foundation

struct KeychainKey {
    static let SessionTokenKey = "SessionTokenKey"
    static let LoggedInUserKey = "LoggedInUserKey"
}

public struct APIConfig {
    static let APIKey = "7b1568b218554e659e942bfed4c4e20d"
}

public struct APIURL {
    static let Base = "https://newsapi.org"
}
