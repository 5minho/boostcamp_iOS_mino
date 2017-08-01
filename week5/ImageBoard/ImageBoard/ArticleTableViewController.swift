//
//  ArticleTableViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ArticleTableViewController : UITableViewController {
    fileprivate var articleList = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        
        UserService.shared.fetchArticles { (articleResult) in
            DispatchQueue.main.async {
                switch articleResult {
                case let .success(articles) :
                    self.articleList = articles
                case .failure(_) :
                    self.articleList.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = articleList[indexPath.row]
        articleCell.update(with: article)
        return articleCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let article = articleList[indexPath.row]
        
        UserService.shared.fetchImageForArticle(article: article, size: .thumbnail) { result in
            DispatchQueue.main.async {
                let articleIndex = self.articleList.index(of: article)!
                let articleIndexPath = IndexPath(row: articleIndex, section: 0)
                
                if let cell = tableView.cellForRow(at: articleIndexPath) as? ArticleTableViewCell {
                    cell.update(with: article)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! DetailArticleViewController
                destination.article = articleList[selectedIndexPath.row]
            }
        }
    }

}
