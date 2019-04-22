//
//  AddingTopicViewController.swift
//  rush00
//
//  Created by Denis SEMERYCH on 4/7/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class AddingTopicViewController: UIViewController {
    @IBOutlet weak var topicName: UITextField!
    @IBOutlet weak var topicContent: UITextView!
    var delegate: SecondViewController?
    
    @IBAction func addTopic(_ sender: Any) {
        guard topicName.text != "", topicContent.text != "" else {return}
        addTopic(withNameAnd: topicName.text!, content: topicContent.text)
        delegate?.topicArray.removeAll()
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension AddingTopicViewController: UITextViewDelegate, UITextFieldDelegate {
    func addTopic(withNameAnd name: String, content: String) {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics.json")!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(GlobalData.intraToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let topic = [
            "topic": [
                "author_id": nil,
                "cursus_ids": ["1"],
                "kind": "normal",
                "language_id": ["5"],
                "messages_attributes": [
                    [
                        "author_id": nil,
                        "content": content,
                        "messageable_id": "1",
                        "messageable_type": "Topic"
                    ],
                ],
                "name": name,
                "tag_ids": ["574"],
                "survey_attributes": nil
            ],
            ]
        let json = try? JSONSerialization.data(withJSONObject: topic, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody = json
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let _ = data, error == nil else {return}
        }.resume()
    }
}
