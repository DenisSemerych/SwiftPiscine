//
//  Test.swift
//  ex01
//
//  Created by Denis SEMERYCH on 4/2/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

class Test {
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
}

let perorme = Test()
perorme.testColors()
perorme.testValues()
