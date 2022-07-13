//
//  ArticleDetailViewController.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 13/07/2022.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    var articleDetails: ArticleDeatils?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ArticleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let imageCount = articleDetails?.media.count {
                return imageCount
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleData = articleDetails else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            guard let articleDetailsCell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.articleDetailsTableViewCell, for: indexPath) as? ArticleDetailsTableViewCell else { return UITableViewCell() }
            articleDetailsCell.configureCell(articleData)
            return articleDetailsCell
        } else {
            guard let articleDetailsCell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.articleImageTableViewCell, for: indexPath) as? ArticleImageTableViewCell else { return UITableViewCell() }
            if let imageUrl = articleData.media[indexPath.row].mediaMetadata?.last?.url {
                articleDetailsCell.configureCell(imageUrl)
            }
            return articleDetailsCell
        }
    }    
}
