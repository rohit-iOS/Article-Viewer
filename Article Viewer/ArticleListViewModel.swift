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
    
    func fetchArticleList(
        success: @escaping () -> Void,
        failure: @escaping () -> Void) {
        
            let url = URL(string: Constants.API.getArticleListURLString + Constants.AppVariables.apiKey)!
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        print(request)
        NetworkManager.shared.request(requetparam: request, fromURL: url) { (result: Result<Data, Error>) in
            
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
