//
//  NewsAPI.swift
//  News App
//
//  Created by Ahmed Maad on 6/4/21.
//  Copyright © 2021 Next Trend. All rights reserved.
//

import Foundation
import UIKit

class NewsAPI{
    
    enum Endpoint {
        case endpoint (String, String)
        
        var url: URL{
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String{
            switch self {
            case .endpoint (let country, let cat):
                return "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(cat)&apiKey=564462700dab42d9abc68614526e96aa"
            }
        }
        
    }
    
    class func getNews(country: String, cat: String, completionHandler: @escaping ([Article], Error?)->Void){
        print("Requesting News")
        let newsEndpoint = NewsAPI.Endpoint.endpoint(country, cat).url
        let task = URLSession.shared.dataTask(with: newsEndpoint) { (data, response, error) in
            guard let data = data else{
                completionHandler([], error)
                print("Request Error: " + (error?.localizedDescription)!)
                return
            }
            do{
            let response = try JSONDecoder().decode(NewsModel.self, from: data)
            let articles = response.articles
            //print("Request Response: " + articles[0].urlToImage)
            completionHandler(articles, nil)
            }
            catch{
                print(error)
            }
            
        }
        task.resume()
        
    }
    
}
