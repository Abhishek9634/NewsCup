//
//  UIViewController+Error.swift
//  Guardian
//
//  Created by Abhishek Thapliyal on 2/2/18.
//  Copyright © 2018 NickelFox. All rights reserved.
//

import Foundation
import FoxAPIKit
import FLUtilities
import Model

extension UIViewController {
    
    func handle(error: AnyError?) {
        if let error = error {
            self.showAlert(title: "Whoops!",
                           message: error.message,
                           actionInterfaceList: [
                            ActionInterface(title: NSLocalizedString("Ok", comment: ""))
                           ]) { (_) in
                            
            }
        } else {
            self.showErrorAlert(message: "Network Failure Please try again Later")
        }
    }
    
    func handle(error: AppError?) {
        if let error = error {
            self.showAlert(title: "Whoops!",
                           message: error.message,
                           actionInterfaceList: [
                            ActionInterface(title: NSLocalizedString("Ok", comment: ""))
            ]) { (_) in
                
            }
        } else {
            self.showErrorAlert(message: "Network Failure Please try again Later")
        }
    }
    
}

enum AppError: Error, LocalizedError {

    case customAny(error: AnyError)
    case customER(error: ErrorResponse)
    
    public var code: Int {
        switch self {
        case .customER(let error):
            return error.code
        case .customAny(let error):
            return error.code
        }
    }
    
    public var message: String {
        switch self {
        case .customER(let error):
            return error.message
        case .customAny(let error):
            return error.message
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .customER(let error):
            return NSLocalizedString(error.message, comment: "")
        case .customAny(let error):
            return NSLocalizedString(error.message, comment: "")
        }
    }
    
}
