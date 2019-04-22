//
//  loadScreenController.swift
//  rush01
//
//  Created by Denis KOTLYAR on 4/14/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit

class loadScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
    }


    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
}
