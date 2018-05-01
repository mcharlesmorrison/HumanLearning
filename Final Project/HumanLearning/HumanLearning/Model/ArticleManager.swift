//
//  ArticleManager.swift
//  HumanLearning
//
//  Created by Morrison on 4/29/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ArticleManager {

    init() {}
    
    func fetch(handle: @escaping (Article) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("articles").observeSingleEvent(of: .value, with: {
            snapshot -> Void in
            if snapshot.exists() {
                let articleKey = Article.randomNum(numRange: Int(snapshot.childrenCount))
                let articleData = snapshot.childSnapshot(forPath: articleKey)
                print(articleData.childSnapshot(forPath: "title").value!)
                let title = articleData.childSnapshot(forPath: "title").value! as! String
                let text = articleData.childSnapshot(forPath: "text").value! as! String
                let link = articleData.childSnapshot(forPath: "link").value! as! String
                let imagePath = articleData.childSnapshot(forPath: "imagePath").value! as! String
                let myArticle = Article(title: title, text: text, imagePath: imagePath, link: link)
                handle(myArticle)
            }
            else {
                print("snapshot does not exist")
            }
        })
    }
}
