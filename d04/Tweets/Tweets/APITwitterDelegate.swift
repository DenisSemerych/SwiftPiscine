//
//  APITwitterDelegate.swift
//  Tweets
//
//  Created by Denis SEMERYCH on 4/5/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

protocol APITwitterDelegate: NSObjectProtocol {
    
    func process(tweets: [Tweet])
    
    func present(error: NSError)
}
