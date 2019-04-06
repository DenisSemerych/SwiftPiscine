//
//  APIControllerClass.swift
//  Tweets
//
//  Created by Denis SEMERYCH on 4/5/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class APIController {
    
    weak var delegate: APITwitterDelegate?
    
    let token: String
    
    var tweets = [Tweet]()
    
    func getTweets(with request: String) {
        let requestQuery = "https://api.twitter.com/1.1/search/tweets.json?q=\(request.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)&lg=eng&count=100"
        guard let url = URL(string: requestQuery) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {self.delegate?.present(error: NSError(domain: url.description, code: 400, userInfo: nil))
                return}
            if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                if let statuses = json?.value(forKey: "statuses") as? [[String:AnyObject]] {
                    guard statuses.count > 0 else {self.delegate?.present(error: NSError(domain: url.description, code: 411, userInfo: nil))
                    return}
                    for status in statuses {
                        self.tweets.append(Tweet(name: status["user"]?.value(forKey: "name") as! String, text: status["text"] as! String, date: status["created_at"] as! String))
                    }
                }
                DispatchQueue.main.sync {
                     self.delegate!.process(tweets: self.tweets)
                }
            } else {
                self.delegate?.present(error: NSError(domain: url.description, code: 404, userInfo: nil))
            }
        }.resume()
    }
    
    static func outh(vc: ViewController) {
        var request = URLRequest(url: URL(string: "https://api.twitter.com/oauth2/token")!)
        request.httpMethod = "POST"
        request.setValue("Basic " + ((TwitterKeys.apiKey.rawValue + ":" + TwitterKeys.apiSecretKey.rawValue).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)), forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
    URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return}
        if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary {
            vc.api = APIController(delegate: vc, token: json.value(forKey: "access_token") as! String)
        }
        }.resume()
    }
    
    init (delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
}
