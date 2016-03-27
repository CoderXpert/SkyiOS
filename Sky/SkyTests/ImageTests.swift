//
//  ImageTests.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import XCTest

@testable import Sky
class ImageTests: XCTestCase {
    /** 
     * Test image construction with valid values, 
     * @expectation properties should have same values as provided in init
     */
    func testImageConstruction(){
        let image = Image(width: 10, height: 20, url: "url1", type: "small")
        XCTAssertNotNil(image, "should not be nil")
        XCTAssertEqual(image.width, 10, "widths should be equal")
        XCTAssertEqual(image.height, 20, "heights should be equal")
        XCTAssertEqual(image.url, "url1", "urls should be equal")
        XCTAssertEqual(image.type, "small", "types should be equal")
    }
    /**
     * This method will test array extension method for image type array
     * Will create different Image objects and add it to array of ImageType
     * @expecation [ImageType].imageForType should return image type provide in parameter, nil otherwise
     */
    func testArrayExtionsForImageType(){
        var images = [Image]()
        let image1 = Image(width: 10, height: 20, url: "url1", type: "small")
        let image2 = Image(width: 30, height: 40, url: "url2", type: "medium")
        let image3 = Image(width: 10, height: 20, url: "url3", type: "large")
        let image4 = Image(width: 10, height: 20, url: "url4", type: "master")
        
        images.append(image1)
        images.append(image2)
        images.append(image3)
        images.append(image4)
        
        let image = images.imageForType("small")
        XCTAssertNotNil(image, "there should be one small image")
        XCTAssertEqual(image?.url, "url1","urls should match")
        XCTAssertEqual(image?.type, "small", "types should match")
        
        let mediumImage = images.imageForType("medium")
        XCTAssertNotNil(mediumImage, "image should not be nil")
        XCTAssertEqual(mediumImage?.url, "url2","urls should match")
        XCTAssertEqual(mediumImage?.type, "medium", "types should match")
        XCTAssertEqual(mediumImage?.width, 30, "widths should be same")
        XCTAssertEqual(mediumImage?.height, 40, "heights should be same")
        
        let masterImage = images.imageForType("master")
        XCTAssertNotNil(masterImage, "image should not be nil")
        XCTAssertEqual(masterImage?.type, "master", "types should be same")
        
        let largeImage = images.imageForType("large")
        XCTAssertNotNil(largeImage, "image should not be nil")
        XCTAssertEqual(largeImage?.type, "large", "types should be same")
        
        // test with wrong type
        
        XCTAssertNil(images.imageForType("mytype"), "should be nil")
        
        
    }
    
}
