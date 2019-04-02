//
//  Card.swift
//  
//
//  Created by Denis SEMERYCH on 4/2/19.
//

import Foundation


class Card: NSObject {
    let color: Color
    let value: Value
    
    override var description : String {
        get {
        return "The card is \(value) of suit \(color)"
        }
    }
    
    static func ==(left: Card, right: Card) -> Bool {
        return (left.color.rawValue == right.color.rawValue && left.value.rawValue == right.value.rawValue)
    }
    
    override func isEqual (to object: Any?) -> Bool {
        if let card = object as? Card {
              return (self.color.rawValue == card.color.rawValue && self.value.rawValue == card.value.rawValue)
        } else {
            return false
        }
    }
    
    init(suit: Color, value: Value ) {
        self.color = suit
        self.value = value
    }
}


