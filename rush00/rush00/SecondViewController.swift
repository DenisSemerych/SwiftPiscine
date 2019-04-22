//
//  SecondViewController.swift
//  rush00
//
//  Created by Eugene Fedorych on 1/20/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var topicArray: [Topic] = []
    var msgArray: [Message] = []
    @IBOutlet weak var topicsTable: UITableView!
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let cookieJar = HTTPCookieStorage.shared
        for cookie in cookieJar.cookies! {
            cookieJar.deleteCookie(cookie)
        }
        GlobalData.intraToken = ""
        performSegue(withIdentifier: "backToLogin", sender: self)
    }
    @IBAction func addTopic(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddingTopic", sender: self)
    }
    
    func requestToken() {
    let BEARER = ((GlobalData.clientID + ":" + GlobalData.clientSecret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {
        print("Error: URL")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
    request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = "grant_type=authorization_code&client_id=\(GlobalData.clientID)&client_secret=\(GlobalData.clientSecret)&code=\(GlobalData.intraCode)&redirect_uri=rush00%3A%2F%2Fforum".data(using: String.Encoding.utf8)
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {return}
        if let dictionary: NSDictionary = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary {
            if let token = dictionary["access_token"] as? String {
                GlobalData.intraToken = token
                DispatchQueue.main.async {
                    self.getTopics()
                }
            }
        }
    }.resume()
}

func getTopics() {
    var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics.json")!)
    request.httpMethod = "GET"
    request.setValue("Bearer \(GlobalData.intraToken)", forHTTPHeaderField: "Authorization")
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {return}
        do {
            if let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
                for topicItem in response {
                    if let author = topicItem["author"] as? NSDictionary {
                        if let login = author["login"] as? String {
                            if let message = topicItem["message"] as? NSDictionary {
                                if let content = message["content"] as? NSDictionary {
                                    if let markdown = content["markdown"] as? String {
                                        self.topicArray.append(Topic(author: login, date: topicItem["created_at"] as! String, title:  topicItem["name"] as! String, content: markdown, messagesURL: URL(string: topicItem["messages_url"] as! String)!, topicID: topicItem["id"] as! Int))
                                        DispatchQueue.main.async {
                                            self.topicsTable.reloadData()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (let error) {
                print(error)
            }
        }.resume()
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMessage" {
            let index = (sender as! IndexPath).row
            let destVC = segue.destination as! MessageViewController
            print(topicArray[index].author)
            destVC.authorText =  topicArray[index].author
            destVC.dateText = topicArray[index].date
            destVC.messageText = topicArray[index].content
            destVC.msgURL = topicArray[index].messagesURL
            destVC.topicID = topicArray[index].topicID
        } else if segue.identifier == "goToAddingTopic" {
            let destVC = segue.destination as! AddingTopicViewController
            destVC.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        getTopics()
        self.topicsTable.reloadData()
    }
}

//MARK: TableViewController methods

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.topicsTable.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TopicsTableViewCell;
        tableView.rowHeight = 108;
        cell.topicName.text = topicArray[indexPath.row].title
        cell.topicAuthor.text = topicArray[indexPath.row].author
        cell.topicDate.text = topicArray[indexPath.row].date
        cell.topicID = topicArray[indexPath.row].topicID
        return cell;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {action, index in
            let cell = tableView.cellForRow(at: indexPath) as! TopicsTableViewCell
            var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics/\(cell.topicID!)")!)
            request.httpMethod = "DELETE"
            request.setValue("Bearer \(GlobalData.intraToken)", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else {return}
                }.resume()
            DispatchQueue.main.async {
                self.topicArray.removeAll()
                self.getTopics()
                self.topicsTable.reloadData()
            }
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMessage", sender: indexPath)
    }
}

