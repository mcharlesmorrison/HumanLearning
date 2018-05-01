//
//  ViewController.swift
//  HumanLearning
//
//  Created by Morrison on 4/18/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController, UIViewControllerTransitioningDelegate {

    // MARK: IB Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var articlesSavedLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var seeSavedButton: UIButton!
    
    // MARK: Properties
    var blurEffectView: UIVisualEffectView?
    
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

    
    @IBAction func savedArticlesButtonPressed(_ sender: Any) {
    }
    
    @IBAction func learnButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "learnButtonSegue",
                     sender: nil)
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        /**
         * [src] https://stackoverflow.com/questions/29219688/present-modal-view-controller-in-half-size-parent-controller/45525284
         * Instructions for understanding partially presented view controller, using a presentation controller
         */
        let menuController = storyboard!.instantiateViewController(withIdentifier: "optionsMenuViewController")
            as! OptionsMenuViewController
        menuController.modalPresentationStyle = .custom
        menuController.transitioningDelegate = self
        menuController.view.backgroundColor = .black
        self.addBlurEffect()
        menuController.onToggledMenuButtonDidTouch = {
            self.removeBlurEffect()
            menuController.dismiss(animated: true, completion: nil)
        }
        
        present(menuController, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return OptionsMenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // MARK: Helpers
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = self.view.bounds
        blurEffectView!.alpha = 0.95
        
        view.addSubview(blurEffectView!)
    }
    
    func removeBlurEffect() {
        if let blurEffectView = blurEffectView {
            blurEffectView.removeFromSuperview()
        }
    }
    
    
}

