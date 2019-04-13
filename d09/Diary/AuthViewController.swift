//
//  ViewController.swift
//  Diary
//
//  Created by Denis SEMERYCH on 13/04/2019.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import dsemeryc2019
import LocalAuthentication

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        authUser(action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AuthViewController {
    private func authUser(action: UIAlertAction) {
        let error: NSErrorPointer = nil
        let context = LAContext()
        let reason = "Authentication"
        context.evaluatePolicy(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: error) ? .deviceOwnerAuthenticationWithBiometrics : .deviceOwnerAuthentication, localizedReason: reason) {success, error in
            if success {
                self.performSegue(withIdentifier: "goToDiary", sender: self)
            } else if error != nil {
                self.present(error: error!)
            }
        }
    }
    private func present(error: Error) {
        let alert = UIAlertController(title: "Authentication error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: self.authUser(action:)))
        self.present(alert, animated:true)
    }
}
