//
//  ImageType.swift
//  Sky
//
//  Created by Adnan Aftab on 3/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
/**
 * This protocol will defind public interface of an Image Type
 */

protocol ImageType {
    var width:Double {get set}
    var height:Double {get set}
    var url:String {get set}
    var type:String {get set}
}