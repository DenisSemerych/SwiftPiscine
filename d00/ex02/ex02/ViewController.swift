//
//  ViewController.swift
//  ex02
//
//  Created by Denis SEMERYCH on 4/1/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var typing = false
    let calc = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var numberLine: UILabel!
    
    
    @IBAction func calculate(_ sender: UIButton) {
        switch sender.tag {
        case 1...9:
            print("\(sender.tag) is pressed")
            if numberLine.text!.count == 9 {break}
            if typing {numberLine.text! += String(sender.tag)} else {numberLine.text = String(sender.tag)}
            typing = true
        case 10:
            print("Zero pressed\n")
            if typing{numberLine.text! += "0"} else {numberLine.text! = "0"}
        case 11:
            print("Pressed AC button - all arguments is deleted\n")
            typing = false
            numberLine.text! = "0"
            Calculator.arguments = []
            Calculator.operators = []
        case 12:
            print("Negative sign button is pressed")
            if (numberLine.text![numberLine.text!.startIndex] != "-") {
                numberLine.text!.insert("-", at: numberLine.text!.startIndex)
            } else {
                numberLine.text!.remove(at: numberLine.text!.startIndex)
            }
        case 13:
            print("+ is pressed")
            numberLine.text! = calc.save(numbers: numberLine.text!, mod: 13)
            typing = false
        case 14:
            print("- is pressed")
            numberLine.text! = calc.save(numbers: numberLine.text!, mod: 14)
            typing = false
        case 15:
            print("* is pressed")
            numberLine.text! =  calc.save(numbers: numberLine.text!, mod: 15)
            typing = false
        case 16:
            print("\\ is pressed")
            numberLine.text! = calc.save(numbers: numberLine.text!, mod: 16)
            typing = false
        case 17:
            print("= is pressed")
            numberLine.text! = calc.save(numbers: numberLine.text!, mod: 17)
            typing = false
        default:
            break
        }
    }
}

