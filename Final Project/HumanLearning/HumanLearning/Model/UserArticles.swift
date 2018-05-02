//
//  userArticles.swift
//  HumanLearning
//
//  Created by Morrison on 4/30/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class UserArticles {
    
    enum Option {
        case read
        case saved
    }
    
    static let MainDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let savedURL = MainDirectory.appendingPathComponent("saved")
    static let readURL = MainDirectory.appendingPathComponent("read")
    
    static func persist(articles: [Article], _ option: UserArticles.Option) {
        // Matt's change: moved url up here to be able to access it in if statment below. Bao's implementation was throwing and error for unwrapping an optional with value nil
        var url: URL
        switch option {
        case .read:
            url = UserArticles.readURL
        case .saved:
            url = UserArticles.savedURL
        }
        var existingArticles = get(option)
        var isSuccessful: Bool
        
        if existingArticles == nil {
            isSuccessful = NSKeyedArchiver.archiveRootObject(articles, toFile: url.path)
        }
        else {
            for article in existingArticles! {
                if article.title == articles[0].title {
                    return
                }
            }
            existingArticles = existingArticles! + articles
                isSuccessful = NSKeyedArchiver.archiveRootObject(existingArticles!, toFile: url.path)
        }
        guard isSuccessful else {
            debugPrint("Failed to save articles.")
            return
        }
    }
    
    static func get(_ option: UserArticles.Option) -> [Article]? {
        var url: URL
        switch option {
        case .read:
            url = UserArticles.readURL
        case .saved:
            url = UserArticles.savedURL
        }
        
        let list = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [Article]
//        debugPrint(list)
        return list
    }

    // Used to remove article at some index from list, useful for the remove button on the Saved Article Page
    static func removeArticle(position: Int, _ option: UserArticles.Option) {
        
        var url: URL
        switch option {
        case .read:
            url = UserArticles.readURL
        case .saved:
            url = UserArticles.savedURL
        }
        var existingArticles = get(option)
        let isSuccessful: Bool

        existingArticles?.remove(at: position)
        
        isSuccessful = NSKeyedArchiver.archiveRootObject(existingArticles!, toFile: url.path)
        
        guard isSuccessful else {
            debugPrint("Failed to remove articles.")
            return
        }
    }
 
    
    
    
    
}
