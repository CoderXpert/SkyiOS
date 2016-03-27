//
//  Program.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation

/** 
 * Program model class, this will hold all possible info for a program
 */
class Program : ProgramType {
    var title:String?
    var shortDescription:String?
    var synopsis:String?
    var images:[Image]?
    var broadcastChannel:String?
    
    //: Detail info
    var releaseYear:Int?
    var certificate:String?
    var duration:Int?
    
    //: This property will return true if all values exist for program else false
    var programDetailFullyLoaded : Bool {
        get {
            guard let _ = title, _ = synopsis, _ = images, _ = broadcastChannel else {
                return false
            }
            return true
        }
    }
    //: Images
    var smallImage:Image? {
        get {
            guard let imgs = images else { return .None }
            return imgs.imageForType("small")
        }
    }
    var largeImage:Image? {
        get {
            guard let imgs = images else { return .None }
            return imgs.imageForType("large")
        }
        
    }
    var mediumImage:Image? {
        get {
            guard let imgs = images else { return .None }
            return imgs.imageForType("medium")
        }
        
    }
    var masterImage:Image? {
        get {
            guard let imgs = images else { return .None }
            return imgs.imageForType("master")
        }
        
    }
    
    //: Default init method
    init(){}
    
    /**
     * This init method will take min values, but they are also optional
     */
    init(title:String?,shortDescription:String?,synopsis:String?,images:[Image]?,broadcastChannel:String?) {
            self.title = title
            self.shortDescription = shortDescription
            self.synopsis = synopsis
            self.images = images
            self.broadcastChannel = broadcastChannel
    }
}