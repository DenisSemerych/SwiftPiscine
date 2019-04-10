//
//  ViewController.swift
//  Siri
//
//  Created by Denis SEMERYCH on 4/10/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO
import JSQMessagesViewController

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var requestText: UITextField!
    var bot = RecastAIClient(token: "ea108cfff08085600c6b5d63b22ea6a7")
    var client = DarkSkyClient(apiKey: "ed1a17eda13ac778fada7f9c77c92b2f")
    
    @IBAction func sendRequest(_ sender: UIButton) {
        bot.textRequest(requestText.text!, successHandler: getInfo(from: ), failureHandle: presentError(error: ))
    }
    
    
    func getInfo(from response: Response) {
        guard let intent = response.intent(), let location = response.get(entity: "location") else {answer.text = "Error"
            return}
        client.getForecast(latitude: (location["lat"] as! NSNumber).doubleValue, longitude: (location["lng"] as! NSNumber).doubleValue) {result in
            switch result {
            case .success(let forecast, _):
                guard let data = forecast.daily?.data.first else {return}
                DispatchQueue.main.async {
                    guard let location = location["formatted"], let summary = data.summary else {return}
                    self.answer.text = "Wheather in \(location): \(summary) Today temperature low is \(self.convertToCelsius(fahrenheit: data.apparentTemperatureLow)). Today high is \(self.convertToCelsius(fahrenheit: data.apparentTemperatureHigh))"
                }
            case .failure(let error):
                self.presentError(error: error)
            }
        }
        answer.text = intent.slug //"City: \(location["formatted"] as! String)  latitude: \(location["lat"] as! NSNumber) longitude: \(location["lng"] as! NSNumber)"
    }
    
    func presentError(error: Error) {
        answer.text = "Error"
        let alert = UIAlertController(title: "Error in request", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ViewController {
    func convertToCelsius(fahrenheit: Double?) -> Int {
        guard let fahrenheit = fahrenheit else {return 0}
        return Int(5.0 / 9.0 * (fahrenheit - 32.0))
    }
}
