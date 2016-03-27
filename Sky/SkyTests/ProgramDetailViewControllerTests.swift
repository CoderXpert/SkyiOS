//
//  ProgramDetailViewControllerTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest
@testable import Sky
class ProgramDetailViewControllerTests: XCTestCase {
    
    var viewController  : ProgramDetailViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        viewController = storyboard.instantiateViewControllerWithIdentifier("ProgramDetailViewController") as! ProgramDetailViewController
        viewController.loadView()
    }
    /**
     * This method will test viewDidLoad behaviour
     * @expectation should call udpateUI method
     * @expectation should call registerNotification method
     */
    func testViewDidLoadBehaviour(){
        
        let vc = MockDetailViewController()
        XCTAssertFalse(vc.updateUIWasCalled, "updateUI should not be called before viewdidload")
        XCTAssertFalse(vc.registerNotificationsWasCalled, "registerNotification method should not be called before viewDidLoad")
        vc.viewDidLoad()
        XCTAssertTrue(vc.updateUIWasCalled, "viewDidLoad should call updateUI method")
        XCTAssertTrue(vc.registerNotificationsWasCalled, "viewDidLoad shold call update regiseter notificaitons")
    }
    /**
     * This method will test viewModel didSet behhaviour
     * @expecation should call updateUI method
     */
    func testViewModelDidSetBehaviour(){
        let vc = MockDetailViewController()
        XCTAssertFalse(vc.updateUIWasCalled, "updateUI should not be called at the moment")
        let model = ProgramDetailViewModel()
        vc.viewModel = model
        XCTAssertTrue(vc.updateUIWasCalled, "didSet should call updateUI method")
        
    }
    /**
     * This method will test updateUI method
     * @expectation labels should have same value return from viewMdoel
     */
    func testUpdateUIMethod(){        
        let title = "Sky Fall"
        let synopsis = "Starring Daniel Craig"
        let broadcastChannel = "Sky movies"
        let shortDesc = "James Bond"
        
        let program = Program(title: title, shortDescription: shortDesc, synopsis: synopsis, images: .None, broadcastChannel: broadcastChannel)
        program.duration = 160
        let viewModel = ProgramDetailViewModel(program: program)
        viewController.viewModel = viewModel

        XCTAssertNotNil(viewController.titleLabel)
        XCTAssertEqual(viewController.titleLabel?.text, title, "Invalid title")
        XCTAssertEqual(viewController.channelNameLabel?.text, broadcastChannel, "Invalid channel name")
        XCTAssertEqual(viewController.synopsisTextView?.text, synopsis, "Invalid synopsis")
        XCTAssertNil(viewController.imageView?.image, "Image should be nil")
        XCTAssertEqual(viewController.durationLabel?.text, "160 mints","duration text is not vaild")
        
    }

}
