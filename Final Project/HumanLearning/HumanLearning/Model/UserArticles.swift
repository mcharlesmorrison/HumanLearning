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
    
    static func persist(articles: [Article], option: UserArticles.Option) {
        var url: URL
        switch option {
        case .read:
            url = UserArticles.readURL
        case .saved:
            url = UserArticles.savedURL
        }
        
        let isSuccessful = NSKeyedArchiver.archiveRootObject(articles, toFile: url.path)
        
        guard isSuccessful else {
            debugPrint("Failed to save articles.")
            return
        }
    }
    
    static func get(option: UserArticles.Option) -> [Article]? {
        var url: URL
        switch option {
        case .read:
            url = UserArticles.readURL
        case .saved:
            url = UserArticles.savedURL
        }
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [Article]
    }
    
}
