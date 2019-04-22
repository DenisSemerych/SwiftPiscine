//
//  MessageViewController.swift
//  rush00
//
//  Created by Denis SEMERYCH on 4/7/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITextViewDelegate {

    var topicMessages = [Message]()
    var msgURL: URL?
    var messageText: String?
    var authorText: String?
    var dateText: String?
    var topicID: Int?
    
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var responseTeble: UITableView!
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func goToAddingMsg(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddingMsg", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        responseTeble.reloadData()
        message.delegate = self
        responseTeble.delegate = self
        responseTeble.dataSource = self
        message.text = messageText
        author.text = authorText
        date.text = dateText
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        topicMessages.removeAll()
        requestMessages()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToReplies" {
            let destVC = segue.destination as! ReplyViewController
            destVC.replies = sender as? NSArray
        } else if segue.identifier == "goToAddingMsg" {
            let destVC = segue.destination as! AddingMessageViewController
            destVC.topicID = topicID!
            destVC.delegate = self
        }
    }
}

//MARK: TABLE VIEW METHODS

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageViewCell
        cell.author.text = topicMessages[indexPath.row].author
        cell.date.text = topicMessages[indexPath.row].date
        cell.messageText.text = topicMessages[indexPath.row].content
        cell.msgID = topicMessages[indexPath.row].messageID
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToReplies", sender: topicMessages[indexPath.row].replies)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {action, index in
            let cell = tableView.cellForRow(at: indexPath) as! MessageViewCell
            var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/messages/\(cell.msgID!)")!)
            request.httpMethod = "DELETE"
            request.setValue("Bearer \(GlobalData.intraToken)", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else {return}
            }.resume()
            DispatchQueue.main.async {
                self.topicMessages.removeAll()
                self.requestMessages()
                self.responseTeble.reloadData()
            }
        }
        return [delete]
    }
}

//MARK: REQUEST AND DATA PARSING

extension MessageViewController {
    func requestMessages() {
        var request = URLRequest(url: msgURL!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(GlobalData.intraToken)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return}
            if let messages = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
                if messages != nil {self.getMessages(from: messages!)}
            }
        }.resume()
    }
    
    func getMessages(from messages: [NSDictionary]) {
        for index in 1..<messages.count {
            let messages = messages
            let author = (messages[index]["author"] as! NSDictionary)["login"] as! String
            topicMessages.append(Message(author: author, date: messages[index].value(forKey: "created_at") as! String, content: messages[index].value(forKey: "content") as! String, replies: messages[index].value(forKey: "replies") as! NSArray, messageID: messages[index].value(forKey: "id") as! Int))
        }
        DispatchQueue.main.async {
            self.responseTeble.reloadData()
        }
    }
}
