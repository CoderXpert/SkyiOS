//
//  ProgramListViewModelTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky

class ProgramListViewModelTests: XCTestCase {
    
    var viewModel:ProgramListViewModelType!
    
    override func setUp() {
        super.setUp()
        viewModel = MockProgramListViewModel()
    }
    /**
     * This method will test constructor method 
     * @expecation should call getAllProgram method from init
     */
    func testViewModelConstruction(){
        let model = MockProgramListViewModel()
        XCTAssertTrue(model.getAllProgramWasCalled, "getAllProgram method should be called from init")
    }
    /**
     * testViewModel with outbound indexs
     * @expectation should return empty string
     */
    func testViewModelWithOutofBounds() {
        XCTAssertEqual(viewModel.programTitleForIndex(-1), "", "should be empty string")
        XCTAssertEqual(viewModel.programDescriptionForIndex(-1),"", "should be empty string")
        XCTAssertNil(viewModel.programForIndex(-1), "should be nil")
        
        // Test out of bound
        XCTAssertEqual(viewModel.programTitleForIndex(10),"" ,"should be empty string")
        XCTAssertEqual(viewModel.programDescriptionForIndex(10),"", "should be empty string")
        XCTAssertNil(viewModel.programForIndex(10), "should be nil")
    }
    /**
     * This method will test view model with in bound indexs
     * @expectation should return valid expected values
     */
    func testViewModelInBounds(){
        
        XCTAssertNotNil(viewModel.programForIndex(0), "should not be nil")
        XCTAssertEqual(viewModel.programTitleForIndex(0), "title0", "titles should be equal")
        XCTAssertEqual(viewModel.programDescriptionForIndex(0), "sd0", "short descriptions should be equal")
        
        XCTAssertNotNil(viewModel.programForIndex(9), "should not be nil")
        XCTAssertEqual(viewModel.programTitleForIndex(9), "title9", "titles should be equal")
        XCTAssertEqual(viewModel.programDescriptionForIndex(9), "sd9", "short descriptions should be equal")
    }
    /**
     * This method will test method with many objects
     * @expectation should get valid values from view model
     */
    func testAllValues(){
        for i in 0..<10 {
            let title = "title\(i)"
            let sd = "sd\(i)"
            XCTAssertNotNil(viewModel.programForIndex(i), "program should not be nil")
            XCTAssertEqual(viewModel.programTitleForIndex(i), title, "titles should be same")
            XCTAssertEqual(viewModel.programDescriptionForIndex(i), sd, "descriptions values shoudl be equal")
        }
    }
}
