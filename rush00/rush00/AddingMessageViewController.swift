//
//  AddingMessageViewController.swift
//  rush00
//
//  Created by Denis SEMERYCH on 4/7/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class AddingMessageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var messageText: UITextView!
    var topicID : Int?
    var delegate : MessageViewController?
    @IBAction func addMessage(_ sender: UIBarButtonItem) {
        guard messageText.text != "" else {return}
        send(message: messageText.text)
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        delegate?.topicMessages.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageText.delegate = self
    }
}


extension AddingMessageViewController {
    func send(message: String) {
        print(topicID!)
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics/\(topicID!)/messages")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(GlobalData.intraToken)", forHTTPHeaderField: "Authorization")
        let msgJSON = [
            "message": [
                "author_id": 38992,
                "content": message,
                "messageable_id": 1,
            ],
            ]
        let json = try? JSONSerialization.data(withJSONObject: msgJSON, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody = json
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let _ = data, error == nil else {return}
            }.resume()
    }
}
