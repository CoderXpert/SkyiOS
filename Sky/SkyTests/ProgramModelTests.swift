//
//  ProgramModelTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky

class ProgramModelTests: XCTestCase {
    /**
     * This method will test construction, with value
     * @expecation all values should have values provided in init parameter
     */
    func testConstruction(){
        
        var images = [Image]()
        let image = Image(width: 1, height: 1, url: "test", type: "smaller")
        images.append(image)
        let program = Program(title: "title", shortDescription: "sd", synopsis: "sy", images: images, broadcastChannel: "sky movies")
        
        XCTAssertEqual(program.title, "title", "Title is not valid")
        XCTAssertEqual(program.shortDescription, "sd", "Short description is not valid")
        XCTAssertEqual(program.synopsis, "sy", "Synopsis is not valid")
        XCTAssertEqual(program.broadcastChannel, "sky movies", "Channel is not valid")
        XCTAssertNotNil(program.images, "Images should not be nil")
        XCTAssertTrue(program.images?.count == 1, "image count should be 1")
    }
    /**
     * This methid will test program construction with nil values, and then will set values from properties setters
     * @expectation it properties should be nil at start and then should have valid values as set
     */
    func testConstructionWithNil(){
        let program = Program(title: nil, shortDescription: nil, synopsis: nil, images: nil, broadcastChannel: nil)
        XCTAssertNotNil(program, "Should not be nil")
        XCTAssertNil(program.title, "title was not expectated")
        XCTAssertNil(program.shortDescription, "short desc was not expected")
        XCTAssertNil(program.broadcastChannel, "channel name was not expected")
        XCTAssertNil(program.duration, "duration was not expected")
        XCTAssertNil(program.releaseYear, "released year was not expected")
        
        program.title = "title"
        program.shortDescription = "sd"
        program.synopsis = "sy"
        program.broadcastChannel = "sm"
        program.duration = 160
        program.releaseYear = 2009
        
        let image = Image(width: 0, height: 0, url: "url", type:"small")
        program.images = [image]
        
        XCTAssertEqual(program.title, "title", "Title is not valid")
        XCTAssertEqual(program.shortDescription, "sd", "Short description is not valid")
        XCTAssertEqual(program.synopsis, "sy", "Synopsis is not valid")
        XCTAssertEqual(program.broadcastChannel, "sm", "Channel is not valid")
        
        XCTAssertNotNil(program.images, "Should not be nil")
        XCTAssertNotNil(program.smallImage, "Should not be nil")
        XCTAssertEqual(program.smallImage?.type, "small", "Not valid")
        XCTAssertEqual(program.duration, 160, "duration is wrong")
        XCTAssertEqual(program.releaseYear, 2009, "released year is wrong")
    }
    /**
     * Test small image method
     * @expectation method should return Image object with type smaller
     */
    func testSmallImageMethod(){
        var images = [Image]()
        let image = Image(width: 1, height: 1, url: "test", type: "small")
        images.append(image)
        let program = Program(title: "title", shortDescription: "sd", synopsis: "sy", images: images, broadcastChannel: "sky movies")
        XCTAssertNotNil(program.smallImage, "should not be nil")
        XCTAssertEqual(program.smallImage?.type, "small", "Not valid")
        XCTAssertNil(program.largeImage, "should be nil")
        XCTAssertNil(program.masterImage, "should be nil")
        XCTAssertNil(program.mediumImage, "should be nil")
    }
    // @expectation only medium image should return valid value
    func testMediumImageMethod(){
        var images = [Image]()
        let image = Image(width: 1, height: 1, url: "test", type: "medium")
        images.append(image)
        let program = Program(title: "title", shortDescription: "sd", synopsis: "sy", images: images, broadcastChannel: "sky movies")
        XCTAssertNil(program.smallImage, "should be nil")
        XCTAssertNil(program.largeImage, "should be nil")
        XCTAssertNil(program.masterImage, "should be nil")
        XCTAssertNotNil(program.mediumImage, "should not be nil")
        XCTAssertEqual(program.mediumImage?.type, "medium", "Not valid")
    }
    
    // @expectation only large image should return valid value
    func testLargeImageMethod(){
        var images = [Image]()
        let image = Image(width: 1, height: 1, url: "test", type: "large")
        images.append(image)
        let program = Program(title: "title", shortDescription: "sd", synopsis: "sy", images: images, broadcastChannel: "sky movies")
        XCTAssertNil(program.smallImage, "should be nil")
        XCTAssertNotNil(program.largeImage, "should not be nil")
        XCTAssertNil(program.masterImage, "should be nil")
        XCTAssertNil(program.mediumImage, "should be nil")
        XCTAssertEqual(program.largeImage?.type, "large", "Not valid")
    }
    // @expecation only master image should return valid value
    func testMasterImageMethod() {
        var images = [Image]()
        let image = Image(width: 1, height: 1, url: "test", type: "master")
        images.append(image)
        let program = Program(title: "title", shortDescription: "sd", synopsis: "sy", images: images, broadcastChannel: "sky movies")
        XCTAssertNil(program.smallImage, "should be nil")
        XCTAssertNil(program.largeImage, "should be nil")
        XCTAssertNotNil(program.masterImage, "should not be nil")
        XCTAssertNil(program.mediumImage, "should be nil")
        XCTAssertEqual(program.masterImage?.type, "master", "Not valid")
    }
}
