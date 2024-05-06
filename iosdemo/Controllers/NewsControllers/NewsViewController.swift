//
//  MainViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation
import UIKit


class NewsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: "NewsViewCell")
        tableView.rowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "News"
        
        configureTableView()
        
        getNewsData(from: Constants.newsApiUrl)
    }
    
    private func getNewsData(from url: String) {
        let newsApiService = NewsApiService()
        newsApiService.getNewsData(from: url) { result in
            switch result {
            case .success(let response):
                self.articles = response.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
        return min(articles.count, 20)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as! NewsViewCell
        let article = articles[indexPath.row]
        cell.set(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        let articleViewController = ArticleViewController()
        
        articleViewController.article = selectedArticle
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}
