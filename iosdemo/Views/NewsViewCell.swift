//
//  NewsViewCell.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 04.05.2024..
//

import UIKit

class NewsViewCell: UITableViewCell {
    
//    private lazy var newsImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 10
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    private lazy var newsTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .blue
        titleLabel.adjustsFontSizeToFitWidth = true
        return titleLabel
    }()
    private lazy var newsDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.backgroundColor = .red
        descriptionLabel.adjustsFontSizeToFitWidth = true
        return descriptionLabel

    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
        
//        configureImageView()
        
        configureTitleLabel()
        
        configureDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.description
    }
    
//    func configureImageView() {
//        contentView.addSubview(newsImageView)
//        
//        NSLayoutConstraint.activate([
//            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Adjust top spacing as needed
//            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Adjust leading spacing as needed
//            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Adjust trailing spacing as needed
//            newsImageView.heightAnchor.constraint(equalToConstant: 100) // Adjust image height as needed
//        ])
//    }

    func configureTitleLabel() {
        contentView.addSubview(newsTitleLabel)
        
        NSLayoutConstraint.activate([
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Adjust top spacing as needed
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Adjust leading spacing as needed
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8) // Adjust trailing spacing as needed
        ])
    }

    func configureDescriptionLabel() {
        contentView.addSubview(newsDescriptionLabel)
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 8), // Adjust top spacing as needed
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Adjust leading spacing as needed
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Adjust trailing spacing as needed
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Adjust bottom spacing as needed
        ])
    }
}
