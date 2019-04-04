//
//  Model.swift
//  DeathNote
//
//  Created by Denis SEMERYCH on 4/3/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class Data {
    let formatter = DateFormatter()
    var persons = [Person]()
    var reasons = ["Was eaten by dog", "Close shower and fell", "Was shot down by guy in a park"]
    var names = ["Robert", "Carl", "John"]
    var dates = ["2014/june/20 20:02:12", "2015/september/20 20:03:21", "2016/may/17 20:05:21"]
    
    init () {
        formatter.dateFormat = "yyyy/MMMM/dd HH:mm:ss"
        for index in 0..<3 {
            persons.append(Person(name: names[index], deathDate: formatter.date(from: dates[index])!, deathCause: reasons[index]))
        }
    }
}
