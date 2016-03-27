//
//  ImageDownloaderTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/13/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky

class ImageDownloaderTests: XCTestCase {
    let imageDownloader = ImageDownloaderClient()
    /**
     * This method will test getImageFromURL with invlaid URL
     * @expectation should fail downloading image with InvalidURL error
     */
    func testGetImageFromURLWithInvalidURL(){
        let urlString = ""
        let readyExpectation = expectationWithDescription("ready")
        imageDownloader.getImageFromURL(urlString) { (image, error)in
            XCTAssertNotNil(error, "Error was expected")
            XCTAssertNil(image, "image was not expected")
            XCTAssertEqual(error, Error.InvalidURL, "Invalid error")
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0, "Error was not expected")
        }
    }
    
    /**
     * This method will test getImageFromURL with valid URL, we will pass URL 
     * which will point to local image file (to avoid network dependency)
     * @precondition URL should not be nil, otherwise it will fail at start
     * @expectation it should successfully download image from url
     */
    func testGetImageFromURLWithValidURL(){
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.URLForResource("testImage", withExtension: "png")
        guard let url = filePath else{
            XCTFail("URL String should mandatory for this test")
            return
        }
        
        let readyExpectation = expectationWithDescription("ready")
        imageDownloader.getImageFromURL(url.absoluteString) { (image, error)in
            XCTAssertNil(error, "Error was not expected")
            XCTAssertNotNil(image, "image was expected")
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(5) {
            XCTAssertNil($0, "Error was not expected")
        }
    }
}
