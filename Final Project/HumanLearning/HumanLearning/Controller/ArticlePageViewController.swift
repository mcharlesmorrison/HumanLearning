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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let manager = ArticleManager()
        manager.fetch(handle: {
            myArticle -> Void in
            self.articleText.text = myArticle.text
            self.articleTitle.text = myArticle.title
            
            // Need to acces the image from URL
            print("beginning of photo access")
            let session = URLSession(configuration: .default)
            //creating a dataTask
            let listUrlString = myArticle.imagePath
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
                            print("photo access complete for real")
                            }
                        } else {
                            print("Image file is currupted")
                        }
                    } else {
                        print("No response from server")
                    }
                }
            }
            //starting the download task
            getImageFromUrl.resume()
            print("photo access complete")
        })
        
        // Make next button rounded
        nextButton.layer.cornerRadius = 24
        nextButton.clipsToBounds = true
        
        // Make back button rounded
        backButton.layer.cornerRadius = 6
        backButton.clipsToBounds = true
        print("About to hit article title:")
        print(articleTitle.text)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
