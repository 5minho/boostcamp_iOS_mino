//
//  Article.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 31..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class Article {
    var id : String
    var dateCreated : String
    var thumbURL : String
    var thumbImage : UIImage?
    var imageURL : String
    var image : UIImage?
    var authorNickName : String
    var authorId : String
    var imageDescription : String
    var imageTitle : String
    
    
    init(id : String, dateCreated: String, thumbURL : String, imageURL : String, authorNickName : String, authorId : String, imageDescription : String, imageTitle: String) {
        self.id = id
        self.dateCreated = dateCreated
        self.thumbURL = thumbURL
        self.imageURL = imageURL
        self.authorNickName = authorNickName
        self.authorId = authorId
        self.imageDescription = imageDescription
        self.imageTitle = imageTitle
    }
}

extension Article : Equatable {
    static func == (lhs : Article, rhs : Article) -> Bool{
        return lhs.id == rhs.id
    }
}
