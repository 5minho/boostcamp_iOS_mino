//
//  ImageResult.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum DeleteResult {
    case success
    case failure
}

enum LoginResult {
    case success(User)
    case failure(Int, String)
}

enum ImageError : Error {
    case imageCreationError
}

enum ImageSize {
    case thumbnail
    case detail
}

enum PostResult {
    case success
    case failure(Error)
}


enum ArticleResult {
    case success([Article])
    case failure(Error)
}

enum ImageBoardError : Error {
    case invalidJSONData
}

enum EditResult {
    case success
    case failure
}
