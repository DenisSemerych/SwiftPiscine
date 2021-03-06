//
//  TableViewController.swift
//  rush01
//
//  Created by Denis KOTLYAR on 4/13/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit
import MapKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    var matchingItems: [MKMapItem] = []
    var delegate: ViewController?
    var userLocation: MKUserLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateSearchResultsForSearchController(searchText: String?) {
        guard let mapView = delegate?.myMap,
            let searchBarText = searchText else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.matchingItems.insert(MKMapItem.forCurrentLocation(), at: 0)
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if text.isEmpty { self.tableView.reloadData(); return }
        self.updateSearchResultsForSearchController(searchText: text)
    }

}


extension TableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.currentLocation = self.matchingItems[indexPath.item].placemark.location
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ResultCellController {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCellController
        if indexPath.row == 0 {
            cell.textLabel?.text = "My Location"
            cell.textLabel?.textColor = UIColor.red
        } else {
            cell.textLabel?.text = matchingItems[indexPath.row].placemark.name
            cell.detailTextLabel?.text = matchingItems[indexPath.row].placemark.title
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let addStartPoint = UITableViewRowAction(style: .normal, title: "Add start point") {action, index in
            self.delegate?.currentRout["from"] = self.matchingItems[indexPath.item]
            if let _ = self.delegate?.currentRout["from"], let _ = self.delegate?.currentRout["to"] {
                self.navigationController?.popViewController(animated: true)
            }
        }
        let addEndPoint = UITableViewRowAction(style: .normal, title: "Add end point") {action, index in
            self.delegate?.currentRout["to"] = self.matchingItems[indexPath.item]
            if let _ = self.delegate?.currentRout["from"], let _ = self.delegate?.currentRout["to"] {
                self.navigationController?.popViewController(animated: true)
            }
        }
        return [addStartPoint, addEndPoint]
    }
}
