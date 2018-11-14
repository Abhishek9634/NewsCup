//
//  DataModel.swift
//  Model
//
//  Created by Ravindra Soni on 05/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public typealias APICompletion<T> = (APIResult<T>) -> Void

public class DataModel {
    
    public static let shared: DataModel = DataModel()
    
    private init() { }
    
    private let userDefaults = UserDefaults.standard

	public func logout() {

	}
}
