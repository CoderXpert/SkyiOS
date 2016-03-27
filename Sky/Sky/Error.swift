//
//  Error.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation

/**
 * This enum will define all possible errors
 */
enum Error : ErrorType {
    case NetworkError
    case InvalidData
    case NoData
    case InvalidURL
    case OutOfBounds
}