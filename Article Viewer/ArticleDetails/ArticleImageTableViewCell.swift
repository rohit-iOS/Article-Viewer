//
//  ArticleImageTableViewCell.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 13/07/2022.
//

import UIKit

class ArticleImageTableViewCell: UITableViewCell {

    /// IBOutlets
    @IBOutlet weak var articleImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Cell configuration method
    /// - Parameter articleDetails: articleDetails description
    func configureCell(_ imageUrl: String) {
        articleImageView.loadFrom(urlString: imageUrl)
    }
}
