//
//  Messages.swift
//  rush00
//
//  Created by Eugene Fedorych on 1/20/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import Foundation

struct Message: CustomStringConvertible {
    var description: String {
        return "\(author) (\(date)): \(content)"
    }
    
    var author: String
    var date: String
    var content: String
    var replies: NSArray
    var messageID: Int
}
