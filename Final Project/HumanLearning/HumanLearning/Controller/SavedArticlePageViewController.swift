//
//  SavedArticlePageViewController.swift
//  HumanLearning
//
//  Created by Morrison on 5/1/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class SavedArticlePageViewController: UIViewController {
    
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var articleText: UITextView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var removeButon: UIButton!
    
    var article: Article!
    var position: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(article.title)
        
        self.articleTitle.text = article.title
        self.articleText.text = article.text
        
        // Need to acces the image from URL
        let session = URLSession(configuration: .default)
        //creating a dataTask
        let listUrlString = article!.imagePath!
        let myUrl = URL(string: listUrlString)
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
        
        // Make next button rounded
        readMoreButton.layer.cornerRadius = 24
        readMoreButton.clipsToBounds = true
        
        // Make back button rounded
        backButton.layer.cornerRadius = 6
        backButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func readMoreButtonPressed(_ sender: Any) {
        let url = NSURL(string: self.article!.link)!
        UIApplication.shared.openURL(url as URL)
    }
    
    @IBAction func removeButtonPressed(_ sender: Any) {
        UserArticles.removeArticle(position: position, .saved)
        performSegue(withIdentifier: "removeButtonSegue", sender: nil)
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
