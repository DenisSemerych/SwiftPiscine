//
//  ViewController.swift
//  rush01
//
//  Created by Denis KOTLYAR on 4/13/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var currentRout = [String : MKMapItem]()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkLocationAuth()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        centerUserLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locationManager.startUpdatingLocation()
        if (currentLocation != nil) { centerUserLocation() }
        if let startPoint = currentRout["from"], let endPoint = currentRout["to"] {
            buildRoute(from: startPoint, to: endPoint)
            from.text! += " \(startPoint.placemark.title!)"
            toPoint.text! += " \(endPoint.placemark.title!)"
            routView.isHidden = false
        } else if let startPoint = currentRout["from"] {
            currentLocation = startPoint.placemark.location
            from.text! += " \(startPoint.placemark.title!)"
            routView.isHidden = false
        } else if let endPoint = currentRout["to"] {
            currentLocation = endPoint.placemark.location
            toPoint.text! += " \(endPoint.placemark.title!)"
            routView.isHidden = false
        } else {
            routView.isHidden = true
        }
        if (currentLocation != nil) { centerUserLocation() }
    }

    func checkLocationAuth() {
    switch CLLocationManager.authorizationStatus() {
        case .denied:
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }


    func centerUserLocation() {
        guard ((self.locationManager.location?.coordinate) != nil) else { return }
        let center = CLLocationCoordinate2D(latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!)
        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        let region = MKCoordinateRegion.init(center: center, span: span)
        self.myMap.setRegion(region, animated: true)
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
    }
    
//OUTLETS
    @IBOutlet weak var locationButton: UIBarButtonItem!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var routView: UIView!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var toPoint: UILabel!
    
    
    // ACTIONS
    @IBAction func segmentMapControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            myMap.mapType = .standard
        case 1:
            myMap.mapType = .satellite
        case 2:
            myMap.mapType = .hybrid
        default:
            myMap.mapType = .standard
        }
    }
    @IBAction func locationButtonPressed(_ sender: UIBarButtonItem) {
        centerUserLocation()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSearch", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearch" {
            let dest = segue.destination as! TableViewController
            dest.delegate = self
            from.text = "From:"
            toPoint.text = "To:"
            print("kek")
        }
    }

}

//MARK:- Building Route

extension ViewController {
    func buildRoute(from: MKMapItem, to: MKMapItem) {
        
    }
}

