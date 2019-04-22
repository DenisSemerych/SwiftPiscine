//
//  ReplyViewController.swift
//  rush00
//
//  Created by Denis SEMERYCH on 4/7/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var repliesTable: UITableView!
   
    var replies: NSArray?
    var shownReplies = [Message]()
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repliesTable.delegate = self
        repliesTable.dataSource = self
        parseReplies()
        repliesTable.reloadData()
    }
}

//MARK: Table methods

extension ReplyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownReplies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell") as! MessageViewCell
        cell.author.text = shownReplies[indexPath.row].author
        cell.date.text = shownReplies[indexPath.row].date
        cell.messageText.text = shownReplies[indexPath.row].content
        return cell
    }
}

//MARK: Data Parsing

extension ReplyViewController {
    func parseReplies() {
        for replie in replies! {
            let replie = replie as! NSDictionary
            let author = (replie.value(forKey: "author") as! NSDictionary).value(forKey: "login") as! String
            shownReplies.append(Message(author: author, date: replie.value(forKey: "created_at") as! String, content: replie.value(forKey: "content") as! String, replies: NSArray(), messageID: 0))
        }
    }
}
