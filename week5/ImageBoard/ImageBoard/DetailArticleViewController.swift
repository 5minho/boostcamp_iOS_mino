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
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if appDelegate?.loginUesr?.id == article.authorId {
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
            self.navigationItem.setRightBarButtonItems([editButton, deleteButton], animated: false)
        }
        
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
