//
//  ArticleCollectionViewCell.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 12/07/2022.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {

    /// IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Cell configuration method
    /// - Parameter articleDetails: articleDetails description
    func configureCell(_ articleDetails: ArticleDeatils) {
        self.titleLabel.text = articleDetails.title
        self.detailLabel.text = articleDetails.abstract
        self.dateLabel.text = articleDetails.publishedDate
    }

}
