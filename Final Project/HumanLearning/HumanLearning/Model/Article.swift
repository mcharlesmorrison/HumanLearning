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

class Article {
    
    var title : String!
    var text : String!
    var imagePath : String!
    var link : String!

    init() {
        // Trying to access the data from Firebase and store it in a list of keys, then I'll try to get a random

    }
    
    // Generates a random number in string form like 'thirty-two' which will correspond to the key for an article. This function will eventually need to check whether the number has already been read by the user (basically if this article key is in the users list of already reads
    func randomNum(numRange: Int) -> String {
        let randomNum = arc4random_uniform(UInt32(numRange))
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        return formatter.string(from: NSNumber(value: randomNum))!
        
    }
}
