//
//  ArticleListViewController.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 12/07/2022.
//

import UIKit

final class ArticleListViewController: UIViewController {
    
    ///Private Properties
    private var viewModel = ArticleListViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAericleListData()

    }
    
    /// API call to get ArticleList Data
    private func getAericleListData() {
        viewModel.fetchArticleList() {
            DispatchQueue.main.async { [weak self] in

            }
        } failure: {
            DispatchQueue.main.async { [weak self] in
                self?.showErrorAlert()
            }
        }
    }
    
    func showErrorAlert() {
        let failureMessage = UIAlertController(title: "Failure", message: "Something went wrong.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        failureMessage.addAction(ok)
        self.present(failureMessage, animated: true, completion: nil)
    }

}
