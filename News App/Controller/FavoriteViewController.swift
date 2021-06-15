//
//  FavoriteViewController.swift
//  News App
//
//  Created by Ahmed Maad on 6/15/21.
//  Copyright © 2021 Next Trend. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites: [Favorite] = []
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

        let fetch:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        if let result = try? dataController.viewContext.fetch(fetch){
            favorites = result
            print("favorites count = \(favorites.count)")
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.favorites[indexPath.row].title
        return cell
    }
    
    

}
