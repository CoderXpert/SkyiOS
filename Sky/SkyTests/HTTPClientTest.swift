//
//  HTTPClientTest.swift
//  Sky
//
//  Created by Adnan Aftab on 3/13/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest
@testable import Sky
class HTTPClientTest: XCTestCase {
    
    let httpClient = HttpClient()
    
    /**
     * This method will test fetchDataFromURL method with an invalid URL
     * @precondition URL should not be nil otherwise it will fail at start
     * @expectation it should fail with NetworkError
     */
    func testFetchDataFromURLWithInvalidURL(){
        guard let url = NSURL(string: "invalidurl") else {
            // URL is mandatory for this test
            // Failing test so it raise an alaram
            XCTFail("URL is mandatory for this test")
            return
        }
        
        let readyExpectation = expectationWithDescription("ready")
        httpClient.fetchDataFromServer(url) { (data, error) in
            XCTAssertNotNil(error, "Error was expected")
            XCTAssertNil(data, "Data was not expected")
            XCTAssertEqual(error, Error.NetworkError, "Network error was expected")
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0,"Error was not expected")
        }
        
    }
    /**
     * This method will test fetchDataFromURL with valid url, method will pass
     * local url to an image file (to avoid dependency from network)
     * @precondition URL should not be nil, otherwise it will fail at start
     * @expectation it should pass valid data and data can be use to create an 
     * UIImage object
     */
    func testFetchDataFromURLWithValidURL(){
        let bundle = NSBundle(forClass: self.dynamicType)
        guard let url = bundle.URLForResource("testImage", withExtension: "png") else{
            // url is nil may be test image is missing
            // Failing test so it raise an alarm, and tester make sure file is 
            // exist at right place
            XCTFail("test image is missing or not present at right place, please check and re-run this test")
            return
        }
        
        let readyExpectation = expectationWithDescription("ready")
        httpClient.fetchDataFromServer(url) { (data, error)in
            XCTAssertNotNil(data, "data was expected")
            XCTAssertNil(error, "error was not expected")
            
            // lets test if data can construct image and not corrupted
            if let imageData = data {
                let image = UIImage(data: imageData)
                XCTAssertNotNil(image,"image was expected")
            }
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0, "error was not expected")
        }
    }
}
