//
//  QuizTests.swift
//  QuizTests
//
//  Created by 오민호 on 2017. 8. 3..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import XCTest
@testable import Quiz

class QuizTests: XCTestCase {
    var signUpVC : SignUpViewController?
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        signUpVC = nil
    }
    
    func testShouldInputAllItems() {
        let _ = signUpVC?.view
        signUpVC?.emailField.text = ""
        signUpVC?.nickNameField.text = "abc"
        signUpVC?.pwField.text = "abc"
        signUpVC?.pwCheckField.text = "abc"
        
        XCTAssert((signUpVC?.shouldInputAllItems())!)
    }
    
    func testShouldCheckPassword() {
        let _ = signUpVC?.view
        signUpVC?.pwField.text = "123"
        signUpVC?.pwCheckField.text = "123"
        XCTAssert((signUpVC?.shouldCheckPassword())!)
    }
    
    func testVaildURL() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let vaildURL = URL(string: "https://ios-api.boostcamp.connect.or.kr/user")
        XCTAssertEqual(signUpVC?.signUpURL(), vaildURL)
    }
    
    func testSignUpAPI() {
        let promise = expectation(description: "sign up result : success")
        
        signUpVC?.signUpAPI(email: "aaaweqwe",
                            password: "1234",
                            nickName: "ddd") { result in
                                switch result {
                                case .success :
                                    promise.fulfill()
                                case .failure :
                                    XCTFail("SignUp Fail")
                                }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testSingUp() {
        let _ = signUpVC?.view
        XCTAssertEqual(signUpVC?.resultLabel.text, "success")
    }
    
   
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
