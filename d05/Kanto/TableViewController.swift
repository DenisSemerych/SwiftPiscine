//
//  SecondViewController.swift
//  Kanto
//
//  Created by Denis SEMERYCH on 12/1/18.
//  Copyright © 2018 Denis SEMERYCH. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var itemsList: UITableView!
    weak var delegate: FirstViewController?
    
    var items = [Item(adress: "Isla de es vedra", name: "Ibiza", coordinate: CLLocationCoordinate2D(latitude: 38.868216, longitude:1.198128)), Item(adress: "In-Nadur", name: "Tal-Mixta", coordinate: CLLocationCoordinate2D(latitude: 36.063373, longitude: 14.289421)), Item(adress: "Fort Saint Eynard", name: "Fort Saint Eynard", coordinate: CLLocationCoordinate2D(latitude: 45.234853, longitude: 5.763228))]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.itemsList.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = items[indexPath.row].title!
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstVC = tabBarController!.viewControllers![0] as! FirstViewController
        firstVC.place = items[indexPath.row]
        tabBarController?.selectedViewController = tabBarController?.viewControllers?[0]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

