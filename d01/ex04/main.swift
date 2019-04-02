//
//  Test.swift
//  ex01
//
//  Created by Denis SEMERYCH on 4/2/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

class Test {
    let queenOfSpades = Card(suit: Color.spades, value: Value.queen)
    let kingOfDiamond = Card(suit: Color.diamonds, value: Value.king)
    let queenOfSpadesTest = Card(suit: Color.spades, value: Value.queen)
    let deck = Deck()
    
    func testColors() {
        for color in allColors {
            print(color, color.hashValue, color.rawValue)
        }
    }
    
    func testValues() {
        for value in allValues {
            print(value, value.rawValue)
        }
    }
    
    func testDescription() {
        print(queenOfSpadesTest.description)
        print(kingOfDiamond.description)
        print(queenOfSpades.description)
    }
    
    func testEqual() {
        print("Testing equal cards")
        if queenOfSpades.isEqual(to: queenOfSpadesTest) {
            print("queen is equal to queen")
        } else {
            print ("some error")
        }
        print("Testing unequal cards")
        if !queenOfSpadesTest.isEqual(kingOfDiamond){
            print("queen is not equal to king")
        } else {
            print("some error")
        }
        print("Testing == operator")
        queenOfSpades == kingOfDiamond ? print("OK") : print("Wrong")
        queenOfSpadesTest == queenOfSpades ? print("OK") : print("Wrong")
    }
    
    func testDeck() {
        var count = 0;
        print("Printing all cards")
        for card in deck.allCards {
            print(card.description)
            count += 1
        }
        print("Number of cards in the deck = \(count)")
        count = 0;
        print("Printing Spades")
        for card in deck.allSpades {
            print(card.description)
            count += 1
        }
        print("Number of spades cards in the deck = \(count)")
        count = 0
        print("Printing Clubs")
        for card in deck.allClubs {
            print(card.description)
            count += 1
        }
        print("Number of cubs cards in the deck = \(count)")
        print("Printing Diamonds")
        count = 0
        for card in deck.allDiamonds {
            print(card.description)
            count += 1
        }
        print("Number of diamonds cards in the deck = \(count)")
        print("Printing Hearts")
        count = 0
        for card in deck.allHearts {
            print(card.description)
            count += 1
        }
        print("Number of hearts cards in the deck = \(count)")
    }
    func testShuffle() {
        print("Print initial deck")
        for card in deck.allCards {
            print(card.description)
        }
        deck.allCards.shuffleTheDeck()
        print("Print shuffled deck")
        for card in deck.allCards {
            print(card.description)
        }
        print("Print shuffled deck second time")
        deck.allCards.shuffleTheDeck()
        for card in deck.allCards {
            print(card.description)
        }
    }
    func testDescriptionCards() {
        print("Testing description of cards")
        print(deck.description)
    }
    func printCards(deck: Deck) {
        var count = 0
        for card in deck.cards {
            print(card.description)
            count += 1
        }
        print("In deck \(count) cards")
    }
    func printDiscards(deck: Deck) {
        var count = 0
        for card in deck.discards {
            print(card.description)
            count += 1
        }
        print("In discards \(count) cards")
    }
    func printOuts(deck: Deck) {
        var count = 0
        for card in deck.outs {
            print(card.description)
            count += 1
        }
        print("In out \(count) cards")
    }
    func testMethods() {
        print("Testing methods and init for deck")
        var test = Deck(sort: true)
        print("Shuffled deck")
        printCards(deck: test)
        print("Unshuffled deck")
        test = Deck(sort: false)
        printCards(deck: test)
        print("Testing draw method")
        test = Deck(sort: true)
        print("Initial Deck")
        printCards(deck: test)
        let drawed = test.draw()
        print("Cards in the deck")
        printCards(deck: test)
        print("Cards out")
        printOuts(deck: test)
        print("Card moved to outs \(drawed!.description)")
        print("Testing fold")
        printDiscards(deck: test)
        test.fold(card: drawed!)
        print("Printing discards")
        printDiscards(deck: test)
        print("Printing outs")
        printOuts(deck:test)
        print("Printing deck")
        printCards(deck: test)
    }
}

let perorme = Test()
//perorme.testColors()
//perorme.testValues()
//perorme.testDescription()
//perorme.testEqual()
//perorme.testDeck()
//perorme.testShuffle()
//perorme.testDescriptionCards()
perorme.testMethods()

