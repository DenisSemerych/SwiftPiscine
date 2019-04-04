//
//  AddPersonViewController.swift
//  DeathNote
//
//  Created by Denis SEMERYCH on 4/3/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextViewDelegate {

    var data: Data?
    
@IBOutlet weak var deadmanName: UITextField!
@IBOutlet weak var datePicker: UIDatePicker!
@IBOutlet weak var deathDescription: UITextView!

@objc func doneButtonPressed(_ sender: UIBarButtonItem) {
    if deadmanName.hasText {
        print(deadmanName.text!, deathDescription.text!, datePicker.date)
        while deadmanName.text!.count > 10 {
            deadmanName.deleteBackward()
        }
        data?.persons.append(Person(name: deadmanName.text!, deathDate: datePicker.date, deathCause: deathDescription.text! != "Print reason of death here:" ? deathDescription.text! : ""))
        self.navigationController?.popViewController(animated: true)
    } else {
        let allert = UIAlertController(title: "Name missing!", message: "Person without name can`t die, you know", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Go Back", style: .destructive, handler: nil))
        allert.addAction(UIAlertAction(title: "Go to list", style: .cancel, handler: {action in self.navigationController?.popViewController(animated: true)}))
        self.present(allert, animated: true)
    }
}

func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.darkGray {
        textView.text = nil
        textView.textColor? = UIColor.black
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    datePicker.datePickerMode = .dateAndTime
    datePicker.minimumDate = Date()
    deathDescription.layer.borderWidth = 1
    deathDescription.layer.borderColor = UIColor.black.cgColor
    deathDescription.text = "Print reason of death here:"
    deathDescription.textColor = UIColor.darkGray
    deathDescription.delegate = self
    let background = UIColor(patternImage: UIImage(named: "pergament")!)
    deadmanName.backgroundColor = background
    deadmanName.attributedPlaceholder =  NSAttributedString(string: "Enter dead man name here", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
    deathDescription.backgroundColor = background
    datePicker.backgroundColor = background
}

override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
