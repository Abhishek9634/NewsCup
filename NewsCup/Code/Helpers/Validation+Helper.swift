//
//  Validation+Helper.swift
//  TabCare
//
//  Created by Abhishek Thapliyal on 09/10/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import FormValidation

public class EmptyFieldValidator: ValidationProtocol {
    
    var errorMsg: String
    
    public init(errorMsg: String) {
        self.errorMsg = errorMsg
    }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if !value.isEmpty {
            return (true, nil)
        }
        return (false, self.errorMsg)
    }
}

private let SpecialPasswordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"

public class SpecialPasswordValidator: ValidationProtocol {
    
    private let errorMsg = "Password should consist Alphabet, Numeric & Special Char with atleast 8 characters"
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        return value.isValidSpecialPassword ? (true, nil) : (false, self.errorMsg)
    }
}

extension String {
    
    var isValidSpecialPassword: Bool {
        if !isEmpty {
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", SpecialPasswordRegex)
            return passwordTest.evaluate(with: self)
        }
        return false
    }
}
