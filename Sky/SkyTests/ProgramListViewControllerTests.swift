//
//  ProgramListViewControllerTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky

class ProgramListViewControllerTests: XCTestCase {
    let mockViewModel = MockProgramListViewModel()
    var vc : ProgramListViewController!
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        vc = storyboard.instantiateViewControllerWithIdentifier("ProgramListViewController") as! ProgramListViewController
        vc.loadView()
    }
    /**
     * This method will test viewDidLoad behaviour, it will use MockProgramListVC
     * so we can check if methods were called
     * @expectation viewDidLoad method should call regiseterNotification method
     */
    func testViewDidLoadBehaviour() {
        let vc = MockProgramListVC()
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .White)
        let tableView = UITableView()
        vc.spinner = spinner
        vc.tableView = tableView
        
        XCTAssertFalse(vc.registerNotificationWasCalled, "register method should be called from viewDidLoad")
        vc.viewDidLoad()
        XCTAssertTrue(vc.registerNotificationWasCalled, "viewDidLoad should have call registerNotificationMethod")
    }
    /**
     * This method will test refresh button action handler behaviour
     * @expectation on tapping refersh button viewModel refreshContent method 
     * should be called
     */
    func testOnTapRefreshButtonBehaviour(){
        vc.viewModel = mockViewModel
        XCTAssertFalse(mockViewModel.refreshContentWasCalled, "should be false at the moment")
        vc.onTapRefreshButton(vc.refreshButton)
        XCTAssertTrue(mockViewModel.refreshContentWasCalled, "refreshContent method should get call ")
    }
    // Mark: tableView tests
    // @expectation view should not be nil after loadView get called
    func testVCAndViewisNotNil(){
        XCTAssertNotNil(vc, "view controller should not be nil")
        XCTAssertNotNil(vc.view,"View should not be nil")
    }
    // @expectation VC should confrom to tableViewDelegate protocol
    func testVCConfromsToTableViewDelegate(){
        XCTAssertTrue(vc.conformsToProtocol(UITableViewDelegate))
    }
    // @expectation VC should confrom to tableViewDataSource protocol
    func testVCConfromsToTableViewDatasource(){
        XCTAssertTrue(vc.conformsToProtocol(UITableViewDataSource))
    }
    //@expectation tableView delgate should be connected
    func testTableViewDelegateConnected(){
        XCTAssertNotNil(vc.tableView.delegate, "delegate is not connected")
    }
    //@expectation tableView data source should be connected
    func testTableViewDataSourceConnected(){
        XCTAssertNotNil(vc.tableView.dataSource, "data source is not connected")
    }
    /**
     * This method will test number of rows in section method
     * @expectation rows should be same as viewmodel.TotalNumberofRows
     */
    func testNumberOfRows(){
        vc.viewModel = mockViewModel
        vc.onVMFinishLoadingWithSuccess()
        let expectedRows = mockViewModel.totalNumberOfPrograms
        XCTAssertEqual(vc.tableView(vc.tableView, numberOfRowsInSection: 0), expectedRows,"Invalid rows")
    }
    /**
     * This method will test cellForRowAtindexpath method, we will use mockViewModel
     * to avoid dependency on client and test it individiually
     * @expectation cell should not be nil, reuseableIndentifier = cell
     * @expectation textLabel and detailTextlabel text should be same as viewModel
     * titleForindex and shourdDescription for index
     */
    func testCellForRowAtIndexPath(){
        vc.viewModel = mockViewModel
        vc.onVMFinishLoadingWithSuccess()
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = vc.tableView(vc.tableView, cellForRowAtIndexPath: indexPath)
        XCTAssertNotNil(cell, "Cell should not nil")
        XCTAssertEqual(cell.reuseIdentifier, "cell")
        let program = mockViewModel.programForIndex(0)
        XCTAssertEqual(cell.textLabel?.text, program?.title,"title should be equal")
        XCTAssertEqual(cell.detailTextLabel?.text, program?.shortDescription,"short desc should be equal")
        
    }
    /**
     * This method will test viewDidSelectRowAtIndexPath
     * @expectation method should call presentProgramDetailVC with program
     */
    func testTableViewDidSelectRowAtIndexPathBehaviour(){
        let vc = MockProgramListVC()
        vc.viewModel = mockViewModel
        let tableView = UITableView()
        vc.tableView = tableView
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        XCTAssertFalse(vc.presentProgramDetailVcWasCalled, "should be false at start")
        vc.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        XCTAssertTrue(vc.presentProgramDetailVcWasCalled, "didSelectRowAtIndexPath should call present program detail vc")
    }
    /**
     * This method will test viewDidSelectRowAtIndexPath with invalid indexPath
     * @expectation method should not call presentProgramDetailVC with program
     */
    func testTableViewDidSelectRowAtIndexPathWithInvalidIndexPath(){
        let vc = MockProgramListVC()
        vc.viewModel = mockViewModel
        let tableView = UITableView()
        vc.tableView = tableView
        let indexPath = NSIndexPath(forRow: -1, inSection: 0)
        vc.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        XCTAssertFalse(vc.presentProgramDetailVcWasCalled, "didSelectRowAtIndexPath should call present program detail vc")
    }
    // MARK: Notifiation behaviours
    // @expectation should start animating spinner and hide tableView
    func testOnVMStartLoadingDataBehaviour(){
        XCTAssertFalse(vc.spinner.isAnimating(), "This should be false at start")
        vc.errorLabel.hidden = false
        vc.onVMStartLoadingData()
        XCTAssertTrue(vc.tableView.hidden, "tableview should be hidden")
        XCTAssertTrue(vc.errorLabel.hidden, "error should be hidden")
        XCTAssertTrue(vc.spinner.isAnimating(),"spinner should animate")
    }
    
    // @expectation should stop animating and show tableView
    func testOnVMFinishLoadingWithSuccess() {
        let tableView = MockTableView()
        vc.tableView = tableView
        vc.onVMFinishLoadingWithSuccess()
        
        XCTAssertFalse(vc.spinner.isAnimating(), "spinner should stop animating")
        XCTAssertFalse(vc.tableView.hidden, "tableView should not be hidden")
        XCTAssertTrue(tableView.isReloadDataGetCalled, "tableview reload should get called")
    }
    // @expecation should stop aimating
    func testOnVMFinishLoadingWithFailure() {
        vc.onVMStartLoadingData()
        XCTAssertTrue(vc.spinner.isAnimating(), "should start animating")
        vc.onVMFinishLoadingWithFailure()
        XCTAssertFalse(vc.spinner.isAnimating(), "spinner should stop animating")
    }
}
