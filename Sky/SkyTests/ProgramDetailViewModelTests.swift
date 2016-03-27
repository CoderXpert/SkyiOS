//
//  ProgramDetailViewModelTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/11/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky

class ProgramDetailViewModelTests: XCTestCase {
    
    
    var program : Program!
    let title = "Sky Fall"
    let synopsis = "Starring Daniel Craig"
    let broadcastChannel = "Sky movies"
    let shortDesc = "James Bond"
    let duration = 160
    let releasedYear = 2009
    let certificate = "Cert 19"
    
    override func setUp() {
        super.setUp()
        program = Program(title: title, shortDescription: shortDesc, synopsis: synopsis, images: .None, broadcastChannel: broadcastChannel)
        program.releaseYear = releasedYear
        program.duration = duration
        program.certificate = certificate
    }
    /**
     * This method will view model construction with nil proram
     * @expectation title, synopsis, broadcast channel should return empty string
     * @proram should be nil
     */
    func testProgramDetailViewModelConstructionWithNilProgram(){
        let viewModel = MockProgramDetailViewModel()
        XCTAssertFalse(viewModel.loadImageMethodWasCalled, "load image method should not be called when program is nil")
        XCTAssertEqual(viewModel.title , "", "title should equal empty string")
        XCTAssertEqual(viewModel.synopsis, "", "synopsis should equal empty string")
        XCTAssertEqual(viewModel.broadcastChannelName, "", "channel name should equal empty string")
        XCTAssertNil(viewModel.image, "image should be nil")
        XCTAssertNil(viewModel.program, "program should be nil")
        XCTAssertEqual(viewModel.releaseInfoString, "", "should be empty string")
        XCTAssertEqual(viewModel.durationString, "", "should be empty string")
        XCTAssertEqual(viewModel.certificateString, "", "should be empty string")
    }
    /**
     * This method will test ViewModel getters with valid program
     * @expectation it should return valid values
     */
    func testProgramDetailViewModelValidProgram() {
        let viewModel = MockProgramDetailViewModel(program: program)
        
        XCTAssertTrue(viewModel.loadImageMethodWasCalled, "loadImageMethod should be called from init")
        XCTAssertEqual(viewModel.title, title, "both titles should be equal")
        XCTAssertEqual(viewModel.synopsis, synopsis, "both synopsis should be equal")
        XCTAssertEqual(viewModel.broadcastChannelName, broadcastChannel, "both broadcast channels should be equal")
        XCTAssertNotNil(viewModel.program, "program should not be nil")
        XCTAssertNotNil(viewModel.image, "image should be not nil")
        XCTAssertEqual(viewModel.durationString, "160 mints", "not valid")
        XCTAssertEqual(viewModel.releaseInfoString, "2009", "not valid relased year")
        XCTAssertEqual(viewModel.certificateString, "Cert 19", "certificate is not valid")
    }
    /**
     * This method will test program didSet behaviour
     * @expectation it should call loadImageMethod
     */
    func testProgramDidSet(){
        let viewModel = MockProgramDetailViewModel()
        XCTAssertFalse(viewModel.loadImageMethodWasCalled, "loadImageMethod should not be called")
        viewModel.program = program
        XCTAssertTrue(viewModel.loadImageMethodWasCalled, "loadImageMethod should called after program setter being called")
    }
}
