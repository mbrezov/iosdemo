//
//  MoreNewsViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 06.05.2024..
//

import UIKit

class MoreNewsViewController: UIViewController {
    private var articles: [Article] = []
    private var filteredArticles: [Article] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search news"
        return searchController
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MoreNewsCollectionViewCell.self, forCellWithReuseIdentifier: "MoreNewsCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "More News"
        
        configureSearchbar()
        
        configureCollectionView()
        
        getNewsData(from: Constants.newsApiUrl)
    }
    
    private func getNewsData(from url: String) {
        let newsApiService = NewsApiService()
        newsApiService.getNewsData(from: url) { result in
            switch result {
            case .success(let response):
                self.articles = response.articles
                self.filteredArticles = self.articles
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureSearchbar() {
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MoreNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(filteredArticles.count, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreNewsCollectionViewCell", for: indexPath) as! MoreNewsCollectionViewCell
        let article = self.filteredArticles[indexPath.row]
        cell.set(article: article)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticle = filteredArticles[indexPath.row]
        let articleViewController = ArticleViewController(article: selectedArticle)
       
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let boundsWidth = collectionView.bounds.width
        let leftInset = collectionView.contentInset.left
        let rightInset = collectionView.contentInset.right
        let minimumInteritemSpacing = flowLayout.minimumInteritemSpacing
        
        let availableWidth = boundsWidth - leftInset - rightInset - minimumInteritemSpacing
        let width = availableWidth / 2

        return CGSize(width: width, height: 240)
    }
}

extension MoreNewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.isEmpty else {
                self.filteredArticles = self.articles
                collectionView.reloadData()
                return
        }
        
        self.filteredArticles = self.articles.filter { $0.title.lowercased().contains(query.lowercased())}
        collectionView.reloadData()
    }
}
