//
//  NewsViewController.swift
//  News App
//
//  Created by Ahmed Maad on 6/4/21.
//  Copyright © 2021 Next Trend. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cat: String = ""
    var articles = [Article]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Received Category: " + cat)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    func loadData(){
        NewsAPI.getNews(country: "us", cat: cat, completionHandler: handleNewsResponse(articles:error:))
    }
    
    func handleNewsResponse(articles: [Article], error:Error?){
        print("Handling news list response")
        self.articles = articles
        DispatchQueue.main.async {
            print("Showing the data")
            self.articles = articles
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let title:String = String(self.articles[indexPath.row].title!.prefix(20) + "...")
        /*if title != nil {*/
            cell.textLabel?.text = title
/*        }
        else{
            cell.textLabel?.text = "No Title"
        }*/
        
        
        
        /*cell.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        if let url = URL(string: articles[indexPath.row].urlToImage){
            URLSession.shared.dataTask(with: url){(data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        //print("Loaded: " + self.articles[indexPath.row].urlToImage)
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
                else{
                    cell.imageView?.image = UIImage(named: "news logo")
                }
            }.resume()
        }*/
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = articles[indexPath.row].url
        UIApplication.shared.open(URL(string: urlString!)!)
    }
    
}
