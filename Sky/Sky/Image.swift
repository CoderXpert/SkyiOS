//
//  Image.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit

/**
 * This struct is an image type and will hold data for program related images
 */
struct Image : ImageType {
    var width:Double
    var height:Double
    var url:String
    var type:String
}

/**
 * This extension add will provide some methods which will be available only for
 * an array of ImageType
 */
extension Array where Element : ImageType {
    func imageForType(type:String) -> Element? {
        var val : Element?
        for i in self {
            if (i.type == type) {
                val = i
                break
            }
        }
        return val
    }
}