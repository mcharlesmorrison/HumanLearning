//
//  SavedArticleTableViewCell.swift
//  HumanLearning
//
//  Created by Morrison on 5/1/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class SavedArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var savedArticleImage: UIImageView!
    @IBOutlet weak var savedArticleTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
