//
//  ViewController.swift
//  News App
//
//  Created by Ahmed Maad on 6/4/21.
//  Copyright © 2021 Next Trend. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var articles = [Article]()
    var cat: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func openGeneralNews(_ sender: Any) {
        cat = "general"
        openNewsViewController()
    }
    
    @IBAction func openTechnologyNews(_ sender: Any) {
        cat = "technology"
        openNewsViewController()
    }
    
    @IBAction func openBusinessNews(_ sender: Any) {
        cat = "business"
        openNewsViewController()
    }
    
    func openNewsViewController(){
        performSegue(withIdentifier: "newsPage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is NewsViewController {
            let vc = segue.destination as? NewsViewController
            vc?.cat = cat
        }
    }
    
    
    /*NewsAPI.getNews(country: "us", cat: "business", completionHandler: handleNewsResponse(articles:error:))*/
    
    /*func handleNewsResponse(articles: [Article], error:Error?){
        print("Handling news list response")
        self.articles = articles
        DispatchQueue.main.async {
            print("Make the design")
        }
    }*/
    
}

