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
        
        XCTAssertFalse((signUpVC?.shouldInputAllItems())!)
        
        signUpVC?.emailField.text = "d"
        signUpVC?.nickNameField.text = "d"
        signUpVC?.pwField.text = "abc"
        signUpVC?.pwCheckField.text = "abc"
        
        XCTAssert((signUpVC?.shouldInputAllItems())!)
        
        signUpVC?.emailField.text = ""
        signUpVC?.nickNameField.text = "abc"
        signUpVC?.pwField.text = ""
        signUpVC?.pwCheckField.text = "abc"
        
        XCTAssertFalse((signUpVC?.shouldInputAllItems())!)
        
        signUpVC?.nickNameField.text = "abc"
        signUpVC?.pwField.text = "abc"
        signUpVC?.pwCheckField.text = "abc"
        
        XCTAssertFalse((signUpVC?.shouldInputAllItems())!)
        
        
    }
    
    func testShouldCheckPassword() {
        let _ = signUpVC?.view
        signUpVC?.pwField.text = ""
        signUpVC?.pwCheckField.text = ""
        XCTAssertFalse((signUpVC?.shouldCheckPassword())!)
        
        signUpVC?.pwField.text = ""
        signUpVC?.pwCheckField.text = "123"
        XCTAssertFalse((signUpVC?.shouldCheckPassword())!)
        
        signUpVC?.pwField.text = "123"
        signUpVC?.pwCheckField.text = ""
        XCTAssertFalse((signUpVC?.shouldCheckPassword())!)
        
        signUpVC?.pwField.text = "123"
        signUpVC?.pwCheckField.text = "123123"
        XCTAssertFalse((signUpVC?.shouldCheckPassword())!)
        
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
        let successExcpectation = expectation(description: "sign up result : success")
        let failureExcpectation = expectation(description: "sign up result : failure")
        
        signUpVC?.signUpAPI(email: "qqqw1123s",
                            password: "1234",
                            nickName: "ddd") { result in
                                switch result {
                                case .success :
                                    successExcpectation.fulfill()
                                case let .failure(httpResponse) :
                                    XCTFail("SignUp Fail, status Code : \(httpResponse.statusCode)")
                                }
        }
        
        signUpVC?.signUpAPI(email: "test@test.com",
                            password: "1234",
                            nickName: "ddd") { result in
                                switch result {
                                case .success :
                                    XCTFail("SignUp Success")
                                case .failure :
                                    failureExcpectation.fulfill()
                                }
        }

        wait(for: [successExcpectation,failureExcpectation], timeout: 5)
    }
    
}
