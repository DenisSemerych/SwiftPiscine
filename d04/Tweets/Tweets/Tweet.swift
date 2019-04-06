//
//  Tweet.swift
//  Tweets
//
//  Created by Denis SEMERYCH on 4/5/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit


struct Tweet: CustomStringConvertible {
    
    let name: String
    
    let text: String
    
    let date: String 
    
    var description: String {
        get {
            return "Tweet by \(name). Text: \(text)"
        }
    }
}
