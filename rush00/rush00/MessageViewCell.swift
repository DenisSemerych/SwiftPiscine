//
//  MessageViewCell.swift
//  rush00
//
//  Created by Denis SEMERYCH on 4/7/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var date: UILabel!
    var msgID: Int?

}
