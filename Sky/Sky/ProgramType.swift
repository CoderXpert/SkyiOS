//
//  ProgramType.swift
//  Sky
//
//  Created by Adnan Aftab on 3/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
protocol ProgramType{
    //: Primary info
    var title:String? {get set }
    var shortDescription:String? { get set }
    var synopsis:String? { get set }
    var images:[Image]? { get set }
    var broadcastChannel:String? { get set }
    
    //: Detail info
    var releaseYear:Int? { get set }
    var certificate:String? { get set }
    var duration:Int? { get set }
    
    //: This property will return true if all values exist for program else false
    var programDetailFullyLoaded : Bool { get }
    
    var smallImage:Image? { get }
    var largeImage:Image? { get }
    var mediumImage:Image?{ get }
    var masterImage:Image?{ get }
}