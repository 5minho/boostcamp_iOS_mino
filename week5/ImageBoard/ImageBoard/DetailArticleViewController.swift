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
    var delegate : ArticleEditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if appDelegate?.loginUesr?.id == article.authorId {
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit(_:)))
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trash(_:)))
            self.navigationItem.setRightBarButtonItems([deleteButton, editButton], animated: false)
        }
        
        navigationItem.title = article.imageTitle
        
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

    func edit(_ sender: UIBarButtonItem) {
        
    }
    
    func trash(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "삭제", message: "정말 삭제하시겠습니까?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "예", style: .default) { _ in
            UserService.shared.deleteArticle(id: self.article.id) { [unowned self] result in
                switch result {
                case .success :
                    DispatchQueue.main.async {
                        self.delegate?.detailViewController(self, didDeleteArticle: self.article)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure :
                    print("삭제 실패")
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
