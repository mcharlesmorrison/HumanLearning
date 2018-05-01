//
//  Article.swift
//  HumanLearning
//
//  Created by Morrison on 4/18/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class Article: NSObject, NSCoding {
    
    var title: String!
    var text: String!
    var imagePath: String!
    var link: String!

    init(title: String, text: String, imagePath: String, link: String) {
        // Trying to access the data from Firebase and store it in a list of keys, then I'll try to get a random
        self.title = title
        self.text = text
        self.imagePath = imagePath
        self.link = link
    }
    
    // Generates a random number in string form like 'thirty-two' which will correspond to the key for an article. This function will eventually need to check whether the number has already been read by the user (basically if this article key is in the users list of already reads
    static func randomNum(numRange: Int) -> String {
        let randomNum = arc4random_uniform(UInt32(numRange))
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        return formatter.string(from: NSNumber(value: randomNum))!
        
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(imagePath, forKey: "imagePath")
        aCoder.encode(link, forKey: "link")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String,
            let text = aDecoder.decodeObject(forKey: "text") as? String,
            let imagePath = aDecoder.decodeObject(forKey: "imagePath") as? String,
            let link = aDecoder.decodeObject(forKey: "link") as? String else {
            return nil
        }
    
        self.init(title: title, text: text, imagePath: imagePath, link: link)
    }
    
    
}
