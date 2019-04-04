//
//  TableViewController.swift
//  DeathNote
//
//  Created by Denis SEMERYCH on 4/3/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    private lazy var data = Data()
    
    private var formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "blood"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.persons.count
    }

    @IBAction func addPersonButtonIsPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addingPerson", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? AddPersonViewController {
            destVC.data = data
            destVC.title = "Somebody died?"
            destVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: destVC, action: #selector(destVC.doneButtonPressed(_:)))
            destVC.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathInfo", for: indexPath) as! CustomCell
        formatter.dateStyle = .full
        formatter.dateFormat = "yyyy MMMM dd HH:mm:ss"
        cell.date.text! = "\(formatter.string(from: data.persons[indexPath.row].deathDate))"
        cell.deathInfo.text! = data.persons[indexPath.row].deathCause
        cell.name.text! = data.persons[indexPath.row].name
        cell.backgroundView = UIImageView(image:#imageLiteral(resourceName: "pergament"))
        return cell
    }
}
