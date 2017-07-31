//
//  ImageBoardTests.swift
//  ImageBoardTests
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import XCTest

@testable import ImageBoard

class ImageBoardTests: XCTestCase {
    var userService : UserService!
    override func setUp() {
        super.setUp()
        userService = UserService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userService = nil
        super.tearDown()
    }
    
    func testSignUpUser() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        var completed = false
        userService.requestSignUp(email: "qweqwe", password: "123", nickName: "asdvd") {_,_ in
            print("test complete")
            completed = true
        }
        while(true){
            if completed {break}
        }
    }
    
    
    func testLogin() {
        userService.requestLogin(email: "test@test.com", password: "1234") { res in
            print(res.statusCode)
        }
        userService.requestLogin(email: "123", password: "1234") { res in
            print(res.statusCode)
        }
        userService.requestLogin(email: "", password: "1234") { res in
            print(res.statusCode)
        }
        userService.requestLogin(email: "test@asdest.com", password: "1234") { res in
            print(res.statusCode)
        }
        while(true) {}
    }
 
}
