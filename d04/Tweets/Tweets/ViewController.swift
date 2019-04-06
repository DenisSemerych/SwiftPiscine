//
//  ViewController.swift
//  Tweets
//
//  Created by Denis SEMERYCH on 4/5/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, APITwitterDelegate {
  
    var api: APIController?
    
    @IBOutlet weak var tweetsTable: UITableView!
    @IBOutlet weak var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTable.delegate = self
        tweetsTable.dataSource = self
        searchField.delegate = self
        tweetsTable.rowHeight = UITableViewAutomaticDimension
        tweetsTable.estimatedRowHeight = 700
        searchField.becomeFirstResponder()
        APIController.outh(vc: self)
    }
    
    func process(tweets: [Tweet]) {
        tweetsTable.reloadData()
    }
    
    func present(error: NSError) {
        let alert = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oh, bad", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api?.tweets.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetCell
        if let api = api {
            cell.date.text = String(describing: api.tweets[indexPath.row].date.prefix(16))
            cell.name.text = api.tweets[indexPath.row].name.count > 10 ? String(describing: api.tweets[indexPath.row].name.prefix(10)) : api.tweets[indexPath.row].name
            cell.message.text = api.tweets[indexPath.row].text
        }
        return cell
    }
}

extension ViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        api?.tweets.removeAll()
        api?.getTweets(with: searchField.text!)
        searchField.resignFirstResponder()
        return true
    }
}
