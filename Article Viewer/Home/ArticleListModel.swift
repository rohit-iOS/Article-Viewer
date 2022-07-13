//
//  ArticleListModel.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 12/07/2022.
//

import Foundation

struct ArticleListModel: Decodable {
    var status: String
    var num_results: Int
    var results: [ArticleDeatils]
}

struct ArticleDeatils: Decodable {
    var url: String
    var source: String
    var publishedDate: String
    var updated: String
    var title: String
    var abstract: String
    var media: [MediaDetails]
    
    enum CodingKeys: String, CodingKey {
        case url
        case source
        case publishedDate = "published_date"
        case updated
        case title
        case abstract
        case media
    }
    
    
    struct MediaDetails: Decodable {
        var type: String
        var copyright: String
        var mediaMetadata: [MediaItemDetails]?
        
        enum CodingKeys: String, CodingKey {
            case type
            case copyright
            case mediaMetadata = "media-metadata"
        }
     
        struct MediaItemDetails: Codable {
            var url: String
        }
    }
}
