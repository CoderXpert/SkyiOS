//
//  ProgramListViewModelType.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation

/**
 * Notifications for ProgramListView mdoel
 */
enum ProgramListViewModelNotification : String {
    case StartLoadingData = "viewModelStartLoadingProgramList"
    case FinishLoadingDataWithSuccess = "viewModelFinishLoadingProgramDataWithSuccess"
    case FinishLoadingDataWithFailure = "viewModelFinishLoadingProgramDataWithFailure"
}

/**
 * This protocol will define public interface of ProgramList view model
 */
protocol ProgramListViewModelType {
    var title : String { get }
    var totalNumberOfPrograms : Int {get}
    func programTitleForIndex(index:Int) -> String
    func programDescriptionForIndex(index:Int) -> String
    func smallImageForIndex(index:Int, handler:ImageDownloaderHandler) -> Void
    func programForIndex(index:Int) -> ProgramType?
    func refreshContent() -> Void
}