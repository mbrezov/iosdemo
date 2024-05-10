//
//  NewsViewCell.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 04.05.2024..
//

import UIKit
import Kingfisher

class NewsViewCell: UITableViewCell {
    private lazy var articleImageView: UIImageView = {
        let articleImageView = UIImageView()
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.layer.cornerRadius = 10
        articleImageView.clipsToBounds = true
        return articleImageView
    }()
    private lazy var newsTitleLabel: UILabel = {
        let newsTitleLabel = UILabel()
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.textColor = .white
        newsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        newsTitleLabel.adjustsFontForContentSizeCategory = true
        newsTitleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        newsTitleLabel.layer.cornerRadius = 5
        newsTitleLabel.clipsToBounds = true
        return newsTitleLabel
    }()
    private lazy var newsDescriptionLabel: UILabel = {
        let newsDescriptionLabel = UILabel()
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        newsDescriptionLabel.numberOfLines = 3
        newsDescriptionLabel.adjustsFontForContentSizeCategory = true
        return newsDescriptionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurImageView()
        
        configureTitleLabel()
        
        configureDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        
        newsTitleLabel.text = article.title
        
        newsDescriptionLabel.text = article.description
    
        let url = URL(string: article.urlToImage ?? "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
        articleImageView.kf.setImage(with: url)
    }
    
    func configurImageView() {
        contentView.addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articleImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureTitleLabel() {
        contentView.addSubview(newsTitleLabel)

        NSLayoutConstraint.activate([
            newsTitleLabel.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: 8),
            newsTitleLabel.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: -8),
            newsTitleLabel.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: -5)
        ])
    }

    func configureDescriptionLabel() {
        contentView.addSubview(newsDescriptionLabel)
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 5),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
         ])
    }
}
