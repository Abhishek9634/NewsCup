//
//  Int+Random.swift
//  Guardian
//
//  Created by Abhishek on 21/07/18.
//  Copyright © 2018 Ravindra Soni. All rights reserved.
//

import Foundation

extension Int {
    static func randomNumber(min: Int, max: Int)-> Int{
        return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
    }
}
