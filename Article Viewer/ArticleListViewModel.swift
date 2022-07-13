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
    
}


// MARK: - Service call & Parsing
extension ArticleListViewModel {
    
    func fetchArticleList(articleTimeFrame: TimeFrame,
        success: @escaping () -> Void,
        failure: @escaping () -> Void) {
        
        
        let articleListUrl = Constants.API.getArticleListURLString.replacingOccurrences(of: "{period}", with: "\(articleTimeFrame.rawValue)")

        
        guard let fetchArticlesUrl = URL(string: articleListUrl + Constants.AppVariables.apiKey) else { return }
        var articlesListRequest = URLRequest(url: fetchArticlesUrl, timeoutInterval: Double.infinity)
        articlesListRequest.httpMethod = "POST"
        print(articlesListRequest)
        NetworkManager.shared.request(requetparam: articlesListRequest, fromURL: fetchArticlesUrl) { (result: Result<Data, Error>) in
            
            print(result)
            
            switch result {
            case .success(let responseData):
                do {
                    let articleListData = try JSONDecoder().decode(ArticleListModel.self, from: responseData)
                    self.dataSource = articleListData
                    success()
                } catch {
                    print(error)
                    failure()
                }
            case .failure(let error):
                debugPrint("We got a failure while trying to get the data. The error we got was: \(error.localizedDescription)")
                failure()
              
            }
        }
    }
}
