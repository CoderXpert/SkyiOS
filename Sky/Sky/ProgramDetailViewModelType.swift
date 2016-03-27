//
//  ProgramDetailViewModelType.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit

/**
 * This enum defines possible notifications for program detail view mdoel
 */
enum ProgramDetailViewModelNotifications : String {
    case DidStartLoadingData
    case DidFinishLoadingDataWithSuccess
    case DidStartLoadingImageWithFailure
    case DidFinishLoadingImage
}
/**
 * This protocol will define public interface of Program detail view model
 * String properties could be optionals, but I am not keeping them optional, as
 * at the end they will be displayed on label and we can return empty string if 
 * no value exist by this we can avoid optional checks
 */
protocol ProgramDetailViewModelType {
    var title:String { get }
    var synopsis:String { get }
    var broadcastChannelName:String { get }
    var image:UIImage? { get }
    //: detail info 
    var releaseInfoString:String { get }
    var certificateString:String { get }
    var durationString:String { get }
}