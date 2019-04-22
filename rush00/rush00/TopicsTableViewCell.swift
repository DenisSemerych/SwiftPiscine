//
//  TopicsTableViewCell.swift
//  rush00
//
//  Created by Eugene Fedorych on 1/20/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {
    @IBOutlet weak var topicName: UILabel!
    @IBOutlet weak var topicAuthor: UILabel!
    @IBOutlet weak var topicDate: UILabel!
    var topicID: Int?
}
