//
//  Deck.swift
//  
//
//  Created by Denis SEMERYCH on 4/2/19.
//

import Foundation


class Deck : NSObject {
    var allSpades: [Card] = allValues.map({Card(suit: Color.spades, value: $0)})
    var allDiamonds: [Card] = allValues.map({Card(suit: Color.diamonds, value: $0)})
    var allHearts: [Card] = allValues.map({Card(suit: Color.hearts, value: $0)})
    var allClubs : [Card] = allValues.map({Card(suit: Color.clubs, value: $0)})
    var allCards = [Card]()
    
    override init () {
        allCards = allClubs + allDiamonds + allHearts + allSpades
    }
}

extension Array {
    mutating func shuffleTheDeck() {
        for index in self.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
            self.swapAt(index, randomIndex)
        }
    }
}
