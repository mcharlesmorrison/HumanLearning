//
//  SavedPageViewController.swift
//  HumanLearning
//
//  Created by Morrison on 4/29/18.
//  Copyright © 2018 Matthew Morrison. All rights reserved.
//

import UIKit

class SavedPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var savedTableView: UITableView!
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make back button rounded
        backButton.layer.cornerRadius = 6
        backButton.clipsToBounds = true
        
        savedTableView.delegate = self
        savedTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Conform to Protocols
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let savedArticles = UserArticles.get(.saved)!
        for article in savedArticles {
            debugPrint(article.title)
        }
        let vc = storyboard!.instantiateViewController(withIdentifier: "SavedArticlePageViewController") as! SavedArticlePageViewController //your view controller
        vc.article = savedArticles[indexPath.row]
        vc.position = indexPath.row
        self.present(vc, animated: true, completion: nil)

        
    }
    
    // Prepare for Segue to Article
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "savedToArticleSegue" {
//            let savedArticles = UserArticles.get(.saved)!
//            if let dest = segue.destination as? SavedArticlePageViewController {
//                dest.article = savedArticles[selectedIndexPath!.row]
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let savedArticles = UserArticles.get(.saved)
        if savedArticles == nil {
            return 0
        }
        else {
            return savedArticles!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let savedArticles = UserArticles.get(.saved)!
        let selectedArticle = savedArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedArticleTableViewCell", for: indexPath) as! SavedArticleTableViewCell
        
        // Setting label text for cell
        cell.savedArticleTitle.text = selectedArticle.title
        
        // Setting image for cell (need to query image from databse
        
        // Need to acces the image from URL
        let session = URLSession(configuration: .default)
        //creating a dataTask
        let listUrlString = selectedArticle.imagePath
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
                            cell.savedArticleImage.image = image
                            cell.savedArticleImage.reloadInputViews()
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
        return cell
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
