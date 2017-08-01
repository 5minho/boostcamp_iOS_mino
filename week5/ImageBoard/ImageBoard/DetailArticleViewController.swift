//
//  DetailArticleViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class DetailArticleViewController : UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var imageDescription: UILabel!
    
    var article : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.shared.fetchImageForArticle(article: article, size: .detail) { result in
            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case let .failure(error):
                print("Error fetching image for photo\(error)")
            }
        }
        nickName.text = article.authorNickName
        dateCreated.text = article.dateCreated
        imageDescription.text = article.imageDescription
    }
    
}
