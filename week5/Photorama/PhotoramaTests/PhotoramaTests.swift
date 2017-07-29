//
//  PhotoramaTests.swift
//  PhotoramaTests
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import XCTest
@testable import Photorama

class PhotoramaTests: XCTestCase {
    
    var sessionUnderTest : URLSession!
    private var apiKey : String!
    override func setUp() {
        super.setUp()
        sessionUnderTest = PhotoStore().session
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        apiKey = nil
        super.tearDown()
    }
    
    func testValidURL() {
        
    }
    
    func testHttpStatusCode200 () {
        //given
        let url = FlickrAPI.recentPhotosURL()
        let promise = expectation(description: "Status code 200")
        
        //when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
}
