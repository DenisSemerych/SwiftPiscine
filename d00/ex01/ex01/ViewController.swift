//
//  ViewController.swift
//  ex00
//
//  Created by Denis SEMERYCH on 4/1/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = nil
    }
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func printMsgToConsole(_ sender: UIButton) {
        label.text = "Hello World!"
    }
    
}

