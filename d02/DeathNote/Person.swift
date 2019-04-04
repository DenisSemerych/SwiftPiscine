//
//  Person.swift
//  DeathNote
//
//  Created by Denis SEMERYCH on 4/3/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class Person {
    var name: String
    var deathDate: Date
    var deathCause: String
    
    init(name: String, deathDate: Date, deathCause: String) {
        self.name = name
        self.deathDate = deathDate
        self.deathCause = deathCause
    }
}
