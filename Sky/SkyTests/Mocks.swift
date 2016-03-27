//
//  Mocks.swift
//  Sky
//
//  Created by Adnan Aftab on 3/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation
import UIKit

@testable import Sky

/**
 * Creating mock view modelclass to use mock program client
 */
class MockProgramListViewModel : ProgramListViewModel {
    var getAllProgramWasCalled = false
    var refreshContentWasCalled = false
    override func getAllPopularPrograms() {
        getAllProgramWasCalled = true
        let mockClient = MockProgramClient()
        mockClient.fetchAllProgramsFromServer { (programs, error)  in
            self.programs = programs
        }
    }
    override func refreshContent() {
        refreshContentWasCalled = true
    }
}

/**
 * Creating mock program detail view model class to add stub implemntaiton
 * of loadImageFromServer internal method
 */
class MockProgramDetailViewModel : ProgramDetailViewModel {
    var loadImageMethodWasCalled = false
    /**
     * Overriding loadImageMethod to add stub implmentation
     */
    override func loadImageFromServer() {
        loadImageMethodWasCalled = true
        let image = UIImage()
        self.pImage = image
    }
}

/**
 * Creating mock DetailViewController so can add some stub functionality
 */
class MockDetailViewController : ProgramDetailViewController {
    var updateUIWasCalled = false
    var registerNotificationsWasCalled = false
    override func updateUI() {
        updateUIWasCalled = true
    }
    override func registerViewModelNotifications() {
        registerNotificationsWasCalled = true
    }
}

/**
 * Creating mock program list vc class to add stub implmentation for some methods
 */
class MockProgramListVC : ProgramListViewController {
    var registerNotificationWasCalled = false
    var presentProgramDetailVcWasCalled = false
    override func registerViewModelNotifications() {
        registerNotificationWasCalled = true
    }
    override func presentProgramDetailVC(program: ProgramType) {
        presentProgramDetailVcWasCalled = true
    }
}
/**
 * Creating a mock tableView to add stub implementation of reloadData method
 * will need to test behaviour of notification methods, if reload get called or not
 */
class MockTableView : UITableView {
    var isReloadDataGetCalled = false
    override internal func reloadData() {
        isReloadDataGetCalled = true
    }
}
/**
 * creating mock program client to return stub programs
 */
class  MockProgramClient : ProgramClient {
    override func fetchAllProgramsFromServer(completionHandler: ProgramClientCompletionHandler) {
        var programs = [ProgramType]()
        for i in 0..<10 {
            let program = Program(title: "title\(i)", shortDescription: "sd\(i)", synopsis: "sy\(i)", images: nil, broadcastChannel: "ch\(i)")
            programs.append(program)
        }
        completionHandler(programs, .None)
    }
}
