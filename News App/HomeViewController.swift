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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getNews(_ sender: Any) {
        NewsAPI.getNews(country: "us", cat: "business", completionHandler: handleNewsResponse(articles:error:))
    }
    
    func handleNewsResponse(articles: [Article], error:Error?){
        print("Handling news list response")
        self.articles = articles
        DispatchQueue.main.async {
            print("Make the design")
        }
    }
    
}

