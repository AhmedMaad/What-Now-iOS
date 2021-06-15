//
//  NewsViewController.swift
//  News App
//
//  Created by Ahmed Maad on 6/4/21.
//  Copyright © 2021 Next Trend. All rights reserved.
//

import UIKit
import CoreData

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cat: String = ""
    var articles = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Received Category: " + cat)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpress))
        tableView.addGestureRecognizer(longPress)
        
        loadData()
    }
    
    func loadData(){
        NewsAPI.getNews(country: "us", cat: cat, completionHandler: handleNewsResponse(articles:error:))
    }
    
    func handleNewsResponse(articles: [Article], error:Error?){
        if articles.count > 0 {
            print("Handling news list response")
            progress.isHidden = true
            self.articles = articles
            DispatchQueue.main.async {
                print("Showing the data")
                self.articles = articles
                self.tableView.reloadData()
            }
        }
        else{
            print("News Failure...")
            progress.isHidden = true
            DispatchQueue.main.async {
                self.showNewsDialog(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func showNewsDialog(message: String) {
        let alertVC = UIAlertController(title: "Loading News Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let title:String = String(self.articles[indexPath.row].title!.prefix(25) + "...")
        cell.textLabel?.text = title
        
        
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        if let url = URL(string: articles[indexPath.row].urlToImage ?? "nothing"){
            URLSession.shared.dataTask(with: url){(data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(named: "news logo")
                    }
                }
                }.resume()
        }
        
        return cell
    }
    
    //handling long press
    @objc func longpress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // your code here, get the row for the indexPath or do whatever you want
                print("You should save to database")
                //Core Data User Information
                /*var favorite = Favorite()
                do {
                    try NSManagedObjectContext.save(articles[indexPath.row].title)
                    print("Saved to favorite")
                } catch {
                    print("Failure to save: \(error)")
                }*/
            }
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = articles[indexPath.row].url
        UIApplication.shared.open(URL(string: urlString!)!)
    }
    
}
