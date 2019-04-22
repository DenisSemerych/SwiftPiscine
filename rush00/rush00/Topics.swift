//
//  Topics.swift
//  rush00
//
//  Created by Eugene Fedorych on 1/20/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import Foundation

struct Topic: CustomStringConvertible {
    var description: String {
        return "\(author) (\(date)): \(title)"
    }
    
    var author: String
    var date: String
    var title: String
    var content: String
    var messagesURL: URL
    var topicID: Int
}
