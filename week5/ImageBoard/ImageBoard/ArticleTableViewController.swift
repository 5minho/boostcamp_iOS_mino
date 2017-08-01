//
//  ArticleTableViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

protocol ArticleEditDelegate {
    func detailViewController(_: DetailArticleViewController, didDeleteArticle article: Article)
    //func detailViewController(_: DetailArticleViewController, didUpdateArticle article: Article)
}

class ArticleTableViewController : UITableViewController {
    fileprivate var articleList = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)

        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
        
        loadArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadArticles()
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
                destination.delegate = self
                destination.article = articleList[selectedIndexPath.row]
            }
        }
    }
    
    func refresh(sender:AnyObject)
    {
        loadArticles()
        self.refreshControl?.endRefreshing()
    }
    
    func loadArticles() {
        UserService.shared.fetchArticles { (articleResult) in
            DispatchQueue.main.async {
                switch articleResult {
                case let .success(articles) :
                    self.articleList = articles.reversed()
                case .failure(_) :
                    self.articleList.removeAll()
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension ArticleTableViewController : ArticleEditDelegate {
    func detailViewController(_: DetailArticleViewController, didDeleteArticle article: Article) {
        guard let index = articleList.index(of: article) else { return }
        articleList.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
