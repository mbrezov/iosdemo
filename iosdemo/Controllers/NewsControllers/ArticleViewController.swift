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
    
    init(article: Article?) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    private lazy var bookmarkButton: UIBarButtonItem = {
        let bookmarkButton = UIBarButtonItem()
        navigationItem.rightBarButtonItem = bookmarkButton
        let bookmarkImage = isBookmarked() ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let selector = isBookmarked() ? #selector(removeBookmark) : #selector(addBookmark)
        bookmarkButton.image = bookmarkImage
        bookmarkButton.target = self
        bookmarkButton.action = selector
        return bookmarkButton
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureScrollView()
        updateBookmarkButtonImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBookmarkButtonImage()
    }
    
    private func isBookmarked() -> Bool {
        guard let article = article else {
            return false
        }

        if let data = UserDefaults.standard.data(forKey: "bookmarks") {
            if let decodedArticles = try? JSONDecoder().decode([Article].self, from: data) {
                return decodedArticles.contains(where: { $0.title == article.title })
            }
        }
        return false
    }
    
    private func updateBookmarkButtonImage() {
        let bookmarkImage = isBookmarked() ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        bookmarkButton.image = bookmarkImage

        let selector = isBookmarked() ? #selector(removeBookmark) : #selector(addBookmark)
        bookmarkButton.target = self
        bookmarkButton.action = selector
    }
    
    @objc private func addBookmark(){
        guard let article = article else {
            return
        }
        
        BookmarkManager.shared.addBookmark(article)
        updateBookmarkButtonImage()
    }
    
    @objc private func removeBookmark() {
        guard let article = article else {
            return
        }
        
        BookmarkManager.shared.removeBookmark(article)
        updateBookmarkButtonImage()
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
