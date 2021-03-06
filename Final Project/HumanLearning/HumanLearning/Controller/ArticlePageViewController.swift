//
//  ArticlePageViewController.swift
//  HumanLearning
//
//  Created by Morrison on 4/18/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit
import CoreData

class ArticlePageViewController: UIViewController {

    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleText: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    private var gradient: CAGradientLayer!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let manager = ArticleManager()
        manager.fetch(handle: {
            fetchedArticle -> Void in
            self.article = fetchedArticle
           
            // Adding article to File System
            UserArticles.persist(articles: [self.article], .read)
            
            self.articleText.text = fetchedArticle.text
            self.articleTitle.text = fetchedArticle.title
            
            // Need to acces the image from URL
            let session = URLSession(configuration: .default)
            //creating a dataTask
            let listUrlString = fetchedArticle.imagePath
            let myUrl = URL(string: listUrlString!)
            let request = URLRequest(url:myUrl!)
            let getImageFromUrl = session.dataTask(with:  request) { (data, response, error) in
                //if there is any error
                if let e = error {
                    //displaying the message
                    print("Error Occurred: \(e)")
                } else {
                    //in case of now error, checking wheather the response is nil or not
                    if (response as? HTTPURLResponse) != nil {
                        //checking if the response contains an image
                        if let imageData = data {
                            //getting the image
                            let image = UIImage(data: imageData)
                            
                            //displaying the image
                            DispatchQueue.main.async {
                            self.articlePhoto.image = image
                            self.articlePhoto.reloadInputViews()
                            }
                        } else {
                            print("Image file is corrupted")
                        }
                    } else {
                        print("No response from server")
                    }
                }
            }
            //starting the download task
            getImageFromUrl.resume()
        })
        
        // Make next button rounded
        nextButton.layer.cornerRadius = 24
        nextButton.clipsToBounds = true
        
        // Make back button rounded
        backButton.layer.cornerRadius = 6
        backButton.clipsToBounds = true
        
//        //Fading out text with gradient
//        gradient = CAGradientLayer()
//        gradient.frame = articleText.bounds
//        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
//        gradient.locations = [0, 0.1, 0.9, 1]
//        articleText.layer.mask = gradient
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Takes user back to landing page
    @IBAction func backButtonPressed(_ sender: Any) {
    }
    
    // Takes user to next article
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "nextButtonSegue", sender: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        UserArticles.persist(articles: [article], .saved)
        
        let savedArticles = UserArticles.get(.saved)!
    }
    
    
    
    // Messing around with gradients
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //
    //        gradient.frame = articleText.bounds
    //    }
    //
    //    func textViewDidScroll(_ textView: UITextView) {
    //        updateGradientFrame()
    //    }
    //
    //    private func updateGradientFrame() {
    //        gradient.frame = CGRect(
    //            x: 0,
    //            y: articleText.contentOffset.y,
    //            width: articleText.bounds.width,
    //            height: articleText.bounds.height
    //        )
    //    }

}
