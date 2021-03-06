//
//  ArticleListViewController.swift
//  Article Viewer
//
//  Created by Rohit Karyappa on 12/07/2022.
//

import UIKit
import ProgressHUD

final class ArticleListViewController: UIViewController {
    
    ///Private Properties
    private var viewModel = ArticleListViewModel()
    
    /// IBOutlets
    @IBOutlet weak var articleListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        getAericleListData(articleTimeFrame: .day)
    }
    
    /// Method to setup CollectionView
    private func setUpCollectionView() {
        articleListCollectionView.register(UINib(nibName: Constants.Identifiers.articleCollectionViewCell,
                                                 bundle: nil), forCellWithReuseIdentifier: Constants.Identifiers.articleCollectionViewCell)
        articleListCollectionView.collectionViewLayout = getCompositionalLayout()
    }
    
    
    /// API call to get ArticleList Data
    private func getAericleListData(articleTimeFrame: TimeFrame) {
        ProgressHUD.show()
        viewModel.fetchArticleList(articleTimeFrame: articleTimeFrame) {
            DispatchQueue.main.async { [weak self] in
                ProgressHUD.dismiss()
                self?.articleListCollectionView.reloadData()
            }
        } failure: {errorMessage in
            DispatchQueue.main.async { [weak self] in
                ProgressHUD.showFailed()
                self?.showErrorAlert(errorMessage: errorMessage)
            }
        }
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            getAericleListData(articleTimeFrame: .day)
        case 1:
            getAericleListData(articleTimeFrame: .week)
        case 2:
            getAericleListData(articleTimeFrame: .month)
        default:
            break
        }
    }
    
    
    func showErrorAlert(errorMessage: String?) {
        let errorMessageStr = errorMessage ?? "Something went wrong."
        let failureMessage = UIAlertController(title: "Failure", message: errorMessageStr, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        failureMessage.addAction(ok)
        self.present(failureMessage, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? ArticleDetailViewController {
            guard let selectedArticle = sender as? ArticleDeatils else { return }
            detailsViewController.articleDetails = selectedArticle
        }
    }
}

// MARK: - Collectionview related methods
extension ArticleListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let articleCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifiers.articleCollectionViewCell,
            for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let articleData = viewModel.dataSource?.results[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        articleCell.configureCell(articleData)
        return articleCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let articleData = viewModel.dataSource?.results[indexPath.row] {
            self.performSegue(withIdentifier: Constants.Identifiers.showArticleDetailsSegue, sender: articleData)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        /// Create an NSString since the identifier must conform to NSCopying
        let selectedItem = self.viewModel.dataSource?.results[indexPath.row]
        let identifier = NSString(string: "\(indexPath.row)")
        
        /// Create our configuration with an indentifier
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: {
            let storyboard = UIStoryboard(name: Constants.Identifiers.main, bundle: nil)
            guard let articleDetails = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.articleDetailViewController) as? ArticleDetailViewController else {
                return ArticleDetailViewController()
            }
            articleDetails.articleDetails = selectedItem
            return articleDetails
        }, actionProvider: nil)
    }
    
    ///Conpositional layout for collectionview
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemTypeA = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)))
        itemTypeA.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        // Group B
        let groupAItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .estimated(50)))
        groupAItem1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let groupB = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(150)),
            subitems: [groupAItem1])
        
        // Group C
        let groupBItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .estimated(50)))
        groupBItem1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let groupC = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(50)),
            subitems: [groupBItem1])
        
        // Container Group
        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(450)),
            subitems: [itemTypeA, itemTypeA, groupB, groupC])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
