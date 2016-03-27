//
//  ProgramListViewModel.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit

class ProgramListViewModel : ProgramListViewModelType{
   
    private let programClient = ProgramClient()
    internal var programs:[ProgramType]?
    
    init(){
        self.getAllPopularPrograms()
    }
    /**
     * This method will get all will make request to program client to fetch all
     * popular programs from the server, it will keep intrested parties inform by
     * posting notifications, before start and at the end.
     */
    internal func getAllPopularPrograms(){
        
        Utils.postNotificationOnMainThread(ProgramListViewModelNotification.StartLoadingData.rawValue)
        
        programClient.fetchAllProgramsFromServer { (programs, error) in
            guard error == nil else {
                Utils.postNotificationOnMainThread(ProgramListViewModelNotification.FinishLoadingDataWithFailure.rawValue)
                return
            }
            
            guard programs != nil else {
                Utils.postNotificationOnMainThread(ProgramListViewModelNotification.FinishLoadingDataWithFailure.rawValue)
                return
            }
            
            self.programs = programs
            Utils.postNotificationOnMainThread(ProgramListViewModelNotification.FinishLoadingDataWithSuccess.rawValue)
        }
    }
    func refreshContent() {
        getAllPopularPrograms()
    }
}
/**
 * Extension will implement ProgramListViewModelType protocol and will implement 
 * public interfaces i.e (properties and methods)
 */
extension ProgramListViewModel {
    var title : String {
        get {
            return "Popular"
        }
    }
    var totalNumberOfPrograms : Int {
        get {
            guard let prgs = self.programs else { return 0 }
            return prgs.count
        }
    }
    
    func programTitleForIndex(index: Int) -> String {
        guard let prgs = programs else { return "" }
        guard index < prgs.count && index >= 0 else { return "" }
        let program = prgs[index]
        guard let title = program.title else { return "" }
        return title
    }
    
    func programDescriptionForIndex(index: Int) -> String {
        guard let prgs = programs else { return "" }
        guard index < prgs.count && index >= 0 else { return "" }
        let program = prgs[index]
        guard let shortDesc = program.shortDescription else { return "" }
        return shortDesc
    }
    func smallImageForIndex(index:Int, handler:ImageDownloaderHandler) -> Void {
        guard let prgs = programs else {
            handler(nil, Error.NoData)
            return
        }
        guard index < prgs.count && index >= 0 else {
            handler(nil, Error.OutOfBounds)
            return
        }
        let program = prgs[index]
        guard let image = program.smallImage else {
            handler(nil, Error.InvalidURL)
            return
        }
        
        let downloader = ImageDownloaderClient.sharedInstance
        downloader.getImageFromURL(image.url, completionHandler: handler)
    }
    func programForIndex(index:Int) -> ProgramType? {
        guard let prgs = programs else { return .None }
        guard index < prgs.count && index >= 0 else { return .None }
        return prgs[index]
    }
}