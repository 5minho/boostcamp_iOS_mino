//
//  AlticleTableViewCell.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 31..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ArticleTableViewCell : UITableViewCell {
    
    @IBOutlet var thumbImage : UIImageView!
    @IBOutlet var title : UILabel!
    @IBOutlet var author : UILabel!
    @IBOutlet var dateCreated : UILabel!
    
    func update(with article : Article?) {
        if let article = article {
            thumbImage.image = article.thumbImage
            title.text = article.imageTitle
            author.text = article.authorNickName
            dateCreated.text = article.dateCreated
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
}
