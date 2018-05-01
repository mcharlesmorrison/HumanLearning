//
//  OptionsMenuViewController.swift
//  HumanLearning
//
//  Created by Bao Mai on 4/30/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class OptionsMenuViewController: UIViewController {
    @IBOutlet weak var toggledMenuButton: UIButton!
    var onToggledMenuButtonDidTouch: (() -> Swift.Void)?
    
    @IBAction func toggledMenuButtonDidTouch(_ sender: Any) {
        self.onToggledMenuButtonDidTouch?()
    }
}

class OptionsMenuPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height / 1.5)
    }
    
    
    
}
