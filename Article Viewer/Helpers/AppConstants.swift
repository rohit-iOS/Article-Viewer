//
//  AppConstants.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 12/07/2022.
//

import Foundation

struct Constants {
    
    struct AppVariables {
        static let apiKey = "ZfGywKVlnaa758DsWgVvWcF1BmREX5sb"
    }
    
    struct API {
        static let getArticleListURLString = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/{period}.json?api-key="
    }
    
    struct Identifiers {
        static let main = "Main"
        static let articleCollectionViewCell = "ArticleCollectionViewCell"
        static let showArticleDetailsSegue = "showArticleDetailsSegue"
        static let articleDetailsTableViewCell = "ArticleDetailsTableViewCell"
        static let articleImageTableViewCell = "ArticleImageTableViewCell"
        static let articleDetailViewController = "ArticleDetailViewController"
    }
}
