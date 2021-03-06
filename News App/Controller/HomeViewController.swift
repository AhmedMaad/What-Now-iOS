//
//  ViewController.swift
//  News App
//
//  Created by Ahmed Maad on 6/4/21.
//  Copyright © 2021 Next Trend. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var cat: String = ""
    var dataController: DataController!
    
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
            vc?.dataController = self.dataController
        }
        else if segue.destination is FavoriteViewController{
            let vc = segue.destination as? FavoriteViewController
            vc?.dataController = self.dataController
        }
    }
    
    @IBAction func openFavorites(_ sender: Any){
        performSegue(withIdentifier: "favPage", sender: nil)
    }
    
}

