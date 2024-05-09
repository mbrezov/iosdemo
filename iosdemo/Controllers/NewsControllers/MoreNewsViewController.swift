//
//  MoreNewsViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 06.05.2024..
//

import UIKit

class MoreNewsViewController: UIViewController {
    private var articles: [Article] = []
    
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
        
        configureCollectionView()
        
        getNewsData(from: Constants.newsApiUrl)
    }
    
    private func getNewsData(from url: String) {
        let newsApiService = NewsApiService()
        newsApiService.getNewsData(from: url) { result in
            switch result {
            case .success(let response):
                self.articles = response.articles
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
        return min(articles.count, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreNewsCollectionViewCell", for: indexPath) as! MoreNewsCollectionViewCell
        let article = self.articles[indexPath.row]
        cell.set(article: article)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        let articleViewController = ArticleViewController(article: selectedArticle)
       
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalPadding: CGFloat = 30
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - horizontalPadding) / 2
        return CGSize(width: width, height: 240)
    }
}
