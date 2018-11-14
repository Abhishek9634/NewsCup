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
}
