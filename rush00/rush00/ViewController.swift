//
//  ViewController.swift
//  rush00
//
//  Created by Eugene Fedorych on 1/20/19.
//  Copyright © 2019 Eugene Fedorych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func intraLogin(_ sender: Any) {
        print("https://api.intra.42.fr/oauth/authorize?client_id=\(GlobalData.clientID)&redirect_uri=rush00%3A%2F%2Fforum&response_type=code&scope=public%20forum")
        
        if let appURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(GlobalData.clientID)&redirect_uri=rush00%3A%2F%2Fforum&response_type=code&scope=public%20forum") {
            UIApplication.shared.open(appURL) { success in
                if success {
                    print("The URL was delivered successfully.")
                } else {
                    print("The URL failed to open.")
                }
            }
        } else {
            print("Invalid URL specified.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Start")
        
        print(GlobalData.intraCode)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

