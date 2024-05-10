//
//  BookmarkManager.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 09.05.2024..
//
import UIKit
import Foundation

class BookmarkManager {
    static let shared = BookmarkManager()
    
    private init() {}
    
    func articleIsBookmarked(_ article: Article) -> Bool {
        guard let data = UserDefaults.standard.data(forKey: "bookmarks"),
              let decodedArticles = try? JSONDecoder().decode([Article].self, from: data) else {
                return false
            }
        return decodedArticles.contains(where: { $0.title == article.title})
    }
    
    func getBookmarks() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: "bookmarks"),
              let decodedArticles = try? JSONDecoder().decode([Article].self, from: data) else {
                return []
            }
            return decodedArticles
    }
    
    private func saveBookmarks(_ articles: [Article]) {
        if let encodedData = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(encodedData, forKey: "bookmarks")
        }
    }
    
    func addBookmark(_ article: Article) {
        var bookmarkedArticles = getBookmarks()
        bookmarkedArticles.append(article)
        saveBookmarks(bookmarkedArticles)
    }
    
    func removeBookmark(_ article: Article) {
        var bookmarkedArticles = getBookmarks()
        bookmarkedArticles.removeAll { $0.title == article.title}
        saveBookmarks(bookmarkedArticles)
    }
}
