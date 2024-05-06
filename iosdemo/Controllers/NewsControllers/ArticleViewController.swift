//
//  ArticleViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 05.05.2024..
//

import UIKit
import Kingfisher

class ArticleViewController: UIViewController {
    var article: Article?
    private lazy var articleImageView: UIImageView = {
        let articleImageView = UIImageView()
        let url = URL(string: self.article?.urlToImage ?? "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
        articleImageView.kf.setImage(with: url)
        return articleImageView
    }()
    private lazy var articleTitleLabel: UILabel = {
        let articleTitleLabel = UILabel()
        articleTitleLabel.text = article?.title
        articleTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.adjustsFontSizeToFitWidth = true
        articleTitleLabel.adjustsFontForContentSizeCategory = true
        return articleTitleLabel
    }()
    private lazy var articleContentLabel: UILabel = {
        let articleContentLabel = UILabel()
        let repeatedText = (article?.content ?? "")
        articleContentLabel.text = String(repeating: repeatedText, count: 10)
        articleContentLabel.numberOfLines = 0
        articleContentLabel.adjustsFontSizeToFitWidth = true
        articleContentLabel.adjustsFontForContentSizeCategory = true
        return articleContentLabel
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureScrollView()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        let articleView = UIStackView(arrangedSubviews: [articleImageView, articleTitleLabel, articleContentLabel])
        articleView.translatesAutoresizingMaskIntoConstraints = false
        articleView.axis = .vertical
        articleView.spacing = 20
        
        scrollView.addSubview(articleView)
        
        NSLayoutConstraint.activate([
             articleImageView.heightAnchor.constraint(equalToConstant: 200)
         ])
        
        NSLayoutConstraint.activate([
            articleView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            articleView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            articleView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            articleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            articleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
