//
//  ArticleListViewModel.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 12/07/2022.
//

import Foundation

/// ViewModel Class for ArticleListViewModelViewController
final class ArticleListViewModel {
    var dataSource: ArticleListModel?
    
    // MARK: - Service call & Parsing
    func fetchArticleList(articleTimeFrame: TimeFrame,
        success: @escaping () -> Void,
        failure: @escaping (String) -> Void) {
        
        //Clearing Data
        dataSource = nil

        //Forming URL for the fetching list of most viewed articles for seletected period
        let articleListUrl = Constants.API.getArticleListURLString.replacingOccurrences(of: "{period}", with: "\(articleTimeFrame.rawValue)")
        
        //Forming complete URL
        guard let fetchArticlesUrl = URL(string: articleListUrl + Constants.AppVariables.apiKey) else { return }
        let articlesListRequest = URLRequest(url: fetchArticlesUrl, timeoutInterval: Double.infinity)
        NetworkManager.shared.request(requetparam: articlesListRequest, fromURL: fetchArticlesUrl) { (result: Result<Data, Error>) in
            switch result {
            case .success(let responseData):
                do {
                    let articleListData = try JSONDecoder().decode(ArticleListModel.self, from: responseData)
                    self.dataSource = articleListData
                    success()
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                debugPrint("We got a failure while trying to get the data. The error we got was: \(error.localizedDescription)")
                failure(error.localizedDescription)
            }
        }
    }
}
