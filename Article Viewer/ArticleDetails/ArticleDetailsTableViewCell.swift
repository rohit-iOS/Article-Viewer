//
//  ArticleDetailsTableViewCell.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 13/07/2022.
//

import UIKit

class ArticleDetailsTableViewCell: UITableViewCell {
    
    /// IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var editedOnDateLabel: UILabel!
    @IBOutlet weak var source: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Cell configuration method
    /// - Parameter articleDetails: articleDetails description
    func configureCell(_ articleDetails: ArticleDeatils) {
        self.titleLabel.text = articleDetails.title
        self.detailLabel.text = articleDetails.abstract
        self.publishedDateLabel.text = articleDetails.publishedDate
        self.editedOnDateLabel.text = articleDetails.updated.getDateFromString()
        self.source.text = articleDetails.source

    }
}
