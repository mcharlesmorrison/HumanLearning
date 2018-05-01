//
//  SavedPageViewController.swift
//  HumanLearning
//
//  Created by Morrison on 4/29/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class SavedPageViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var SavedtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make back button rounded
        backButton.layer.cornerRadius = 6
        backButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
