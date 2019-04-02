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
}

let perorme = Test()
perorme.testColors()
perorme.testValues()
perorme.testDescription()
perorme.testEqual()
