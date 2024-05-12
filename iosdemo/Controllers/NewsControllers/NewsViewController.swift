//
//  MainViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    private var articles: [Article] = []
    private var filteredArticles: [Article] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search news"
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: "NewsViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "News"
        
        configureSearchbar()
        
        configureTableView()
        
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
                    self.tableView.reloadData()
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
    
    func configureTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(filteredArticles.count, 20)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as! NewsViewCell
        let article = filteredArticles[indexPath.row]
        cell.set(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = filteredArticles[indexPath.row]
        let articleViewController = ArticleViewController(article: selectedArticle)
        
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension NewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.isEmpty else {
                self.filteredArticles = self.articles
                tableView.reloadData()
                return
        }
        
        self.filteredArticles = self.articles.filter { $0.title.lowercased().contains(query.lowercased())}
        tableView.reloadData()
    }
}
