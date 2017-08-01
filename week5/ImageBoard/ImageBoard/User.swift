//
//  User.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

class User : NSObject {
    var id : String
    var email : String
    
    init(id: String, email : String) {
        self.id = id
        self.email = email
    }
}

extension User {
    static func == (lhs : User, rhs : User) -> Bool {
        return lhs.id == rhs.id
    }
}
