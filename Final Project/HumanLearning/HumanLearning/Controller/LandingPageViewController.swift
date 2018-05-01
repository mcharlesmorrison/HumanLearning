//
//  ViewController.swift
//  HumanLearning
//
//  Created by Morrison on 4/18/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var articlesSavedLabel: UILabel!
    
    @IBOutlet weak var seeSavedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting the date on the label
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSinceReferenceDate: 410220000)
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("E, MMMM d")
        // Set template after setting locale
        dateLabel.text = dateFormatter.string(from: date).uppercased()
        
        // Setting articles read this week label text
        // NEED TO MAKE IT ARTICLE FOR 1 ARTICLE
        articlesSavedLabel.text = "articles read"
        
        // Make button rounded
        seeSavedButton.layer.cornerRadius = 24
        seeSavedButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savedArticlesButtonPressed(_ sender: Any) {
    }
    
    @IBAction func learnButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "learnButtonSegue",
                     sender: nil)
    }
    
}

