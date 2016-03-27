//
//  ProgramClientTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/13/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky

/**
 * This class will test program client, it will test parse method with empty, 
 * invalid and valid data
 */
class ProgramClientTests: XCTestCase {
    /**
     * Creating a mock program client which will provide stub implementation of
     * constructURL method.
     */
    class MockURLProgramClient : ProgramClient {
        override func constructURL() -> NSURL? {
            let bundle = NSBundle(forClass: self.dynamicType)
            let url = bundle.URLForResource("Data", withExtension: "json")
            return url
        }
    }
    
    let programClient = ProgramClient()
    /**
     * This method will test parse method with an empty data
     * @expectation parse method fail parseing with an error InvalidData
     */
    func testParseMethodWithEmptyData(){
        let data = NSData()
        let readyExpectation = expectationWithDescription("ready")
        programClient.parseAllProgramData(data) { (programs, error) in
            XCTAssertNotNil(error, "Error was expected")
            XCTAssertNil(programs, "programs were not expected")
            XCTAssertEqual(error, Error.InvalidData, "Invalid data error was expected")
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0, "Error was not expected")
        }
    }
    /**
     * This method will test parse method with invalid data, data is of valid json 
     * type but missing some expected key values( we have remove an important
     * section from data
     * @expectation parse method should fail parsing data with an InvalidData error
     */
    func testParseWithInvalidData(){
        /**
         * I am creating Program client subclass here to use a powerefull new feature of Swift (Nested classes) wehere we can create classes inside any method.
         * this program client class will override construct URL method, and will
         * return url to a corrupted json file
         */
        class MockProgramClientWithInvalidDataURL : ProgramClient {
            // Overriding construct URL method to return url for invalid json data
            override func constructURL() -> NSURL? {
                let bundle = NSBundle(forClass: self.dynamicType)
                let url = bundle.URLForResource("InvalidData", withExtension: "json")
                return url
            }
        }
        
        // lets test the behaviour
        
        let mockClient = MockProgramClientWithInvalidDataURL()
        let fileURL = mockClient.constructURL()
        guard let url = fileURL else {
            XCTFail("URL shuld not be nil for this test")
            return
        }
        let data = NSData(contentsOfURL: url)
        guard let parseableData = data else {
            XCTFail("data should not be nil for this test")
            return
        }
        
        let readyExpectation = expectationWithDescription("ready")
        programClient.parseAllProgramData(parseableData) { (programs, error) in
            XCTAssertNotNil(error, "Error was expected")
            XCTAssertNil(programs, "programs were not expected")
            XCTAssertEqual(error, Error.InvalidData, "Wrong error")
            readyExpectation.fulfill()
        }
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0, "Error was not expected")
        }
    }
    /**
     * test parse method with valid data, this method will use MockClient to fetch 
     * local json data and test, it will fail if local file is missing, or data is 
     * is corrupted, local json file contain 30 programs so we will expect same
     * @expectation parse method should successfully parse 30 programs
     */
    func testParseMethodWithValidData(){
        
        // lets test the method now
        let pc = MockURLProgramClient()
        let fileURL = pc.constructURL()
        guard let url = fileURL else {
            XCTFail("URL shuld not be nil for this test")
            return
        }
        let data = NSData(contentsOfURL: url)
        guard let parseableData = data else {
            XCTFail("data should not be nil for this test")
            return
        }
        
        let readyExpectation = expectationWithDescription("ready")
        pc.parseAllProgramData(parseableData) { (programs, error)  in
            
            XCTAssertNil(error, "Error was not expected here")
            XCTAssertNotNil(programs, "Programs was expected here")
            XCTAssertEqual(programs?.count, 30, "30 programs were expected")
            
            // lets check if all properties were parsed properly
            for p in programs! {
                XCTAssertNotNil(p.title, "title was expected not nil")
                XCTAssertNotNil(p.shortDescription, "short description should not be nil")
                XCTAssertNotNil(p.images, "images should not be nil")
                XCTAssertNotNil(p.broadcastChannel, "channels should not be nil")
                XCTAssertNotNil(p.synopsis, "synposis should not be nil")
            }
            
            readyExpectation.fulfill()
        }
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5) { 
            XCTAssertNil($0, "Error was not expected")
        }
    }
    
    /**
     * Testing fetch all program, this is more like
     * parser method, as it will call super class fetchDataFrom url and then will
     * call parse method and will execute completion handler, but its better to test it individiually as well.
     * @expectation should pass 30 programs to completion handler
     */
    func testFetchAllProgramsMethod(){
        let pc = MockURLProgramClient()
        let readyExpectation = expectationWithDescription("ready")
        pc.fetchAllProgramsFromServer { (programs, error) in
            XCTAssertNil(error, "Error was not expected")
            XCTAssertNotNil(programs, "programs was expected")
            XCTAssertEqual(programs?.count, 30, "30 programs were expected")
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0, "Error was not expected")
        }
    }
}
