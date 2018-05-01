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

    init() {
        
    }
    
    func fetch(handle: @escaping (Article) -> Void) {
        let myArticle = Article()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("articles").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
//                print("snapshot does exist")
                let articleKey = myArticle.randomNum(numRange: Int(snapshot.childrenCount))
                let articleData = snapshot.childSnapshot(forPath: articleKey)
                print(articleData.childSnapshot(forPath: "title").value!)
                myArticle.title = articleData.childSnapshot(forPath: "title").value! as! String
                myArticle.text = articleData.childSnapshot(forPath: "text").value! as! String
                myArticle.link = articleData.childSnapshot(forPath: "link").value! as! String
                myArticle.imagePath = articleData.childSnapshot(forPath: "imagePath").value! as! String

                handle(myArticle)
            }
            else {
                print("snapshot does not exist")
            }
        })
    }
}
