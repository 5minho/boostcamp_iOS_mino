//
//  Photo.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class Photo {
    let title : String
    let remoteURL : URL
    let photoId : String
    let dateTaken : Date
    var image : UIImage?
    
    init(title: String, photoId: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoId = photoId
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}

extension Photo : Equatable{
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoId == rhs.photoId
    }
}
