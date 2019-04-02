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
    var cards = [Card]()
    var discards = [Card]()
    var outs = [Card]()
    
    override var description : String {
        get {
            var allCardsDescription = ""
            for card in cards {
                allCardsDescription += "\(card.description)\n"
            }
            return allCardsDescription
        }
    }
    override init () {
        allCards = allClubs + allDiamonds + allHearts + allSpades
        cards = allCards
    }
    convenience init(sort: Bool) {
        self.init()
        if sort {
            self.cards.shuffleTheDeck()
        }
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

extension Deck {
    func draw() -> Card? {
        if cards.count > 0 {
            let card = cards.removeFirst()
            outs.append(card)
            return card
        } else {
            return nil
        }
    }
    func fold(card: Card) {
        if outs.contains(card) {
            let index = outs.index(of: card)
            discards.append(outs.remove(at: index!))
        }
    }
}
