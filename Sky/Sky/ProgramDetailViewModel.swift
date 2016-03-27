//
//  ProgramDetailViewModel.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit
/**
 * View model class, this class will hold info about program to show in program
 * detail view, this class will also implement ViewModelTypeProtocol
 */
class ProgramDetailViewModel {
    private let imageDownloader = ImageDownloaderClient.sharedInstance
    internal var pImage:UIImage?
    var program : ProgramType? {
        didSet {
            self.loadImageFromServer()
        }
    }
    
    init(){}
    init(program:ProgramType){
        self.program = program
        self.loadImageFromServer()
    }
    
    /**
     * @breif private method to load and image from server
     * @param void
     * @return void, will post a notification once image download successfully
     */
     internal func loadImageFromServer () {
        guard let pr = program else { return }
        guard let i = pr.masterImage else { return }
        imageDownloader.getImageFromURL(i.url) { (image, error)  in
            guard error == .None else { return }
            guard let img = image else { return }
            self.pImage = img
            Utils.postNotificationOnMainThread(ProgramDetailViewModelNotifications.DidFinishLoadingImage.rawValue)
        }
    }
}
/**
 * Extension will implement ProgramDetailViewModelType protocol and will implement
 * public interfaces i.e (properties and methods)
 */
extension ProgramDetailViewModel : ProgramDetailViewModelType {
    var title:String {
        get {
            guard let pr = program else { return "" }
            guard let t = pr.title else { return "" }
            return t
        }
    }
    var synopsis:String {
        get{
            guard let pr = program else { return "" }
            guard let s = pr.synopsis else { return "" }
            return s
        }
    }
    var broadcastChannelName:String {
        get{
            guard let pr = program else { return "" }
            guard let c = pr.broadcastChannel else { return "" }
            return c
        }
    }
    var image:UIImage? {
        get {
            return pImage
        }
    }
    //: Detail info
    var releaseInfoString:String {
        get {
            guard let pr = program else { return "" }
            guard let ry = pr.releaseYear else { return "" }
            return "\(ry)"
        }
    }
    var certificateString:String {
        get {
            guard let pr = program else { return "" }
            guard let c = pr.certificate else { return "" }
            return c
        }
    }
    var durationString:String {
        get {
            guard let pr = program else { return "" }
            guard let d = pr.duration else { return "" }
            return "\(d) mints"
        }
    }
}
