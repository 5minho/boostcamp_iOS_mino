//
//  BoostCampAPI.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation


struct ImageBoardAPI {
    private static let baseURLString = "https://ios-api.boostcamp.connect.or.kr"
    
    static func signUpURL() -> URL? {
        return URL(string: baseURLString + "/user")
    }
    
    static func loginURL() -> URL? {
        return URL(string: baseURLString + "/login")
    }
}
