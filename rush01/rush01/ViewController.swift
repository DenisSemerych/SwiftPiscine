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
    var colors = [UIColor]()
    
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
        colors = [.red, .purple, .blue]
        locationManager.startUpdatingLocation()
        if let startPoint = currentRout["from"], let endPoint = currentRout["to"] {
            chooseType()
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
            currentRout.count == 2 ? currentRout.removeAll() : nil
            print("kek")
        }
    }
    
    func present(error: Error?) {
        guard let error = error else {return}
        let alert = UIAlertController(title: "Coudn`t bild route", message: error.localizedDescription, preferredStyle: .alert)
        let tryAnotherTransportType = UIAlertAction(title: "Try another transport type", style: .default) {action in self.chooseType()}
        let cancel = UIAlertAction(title: "Cancel and delete points", style: .cancel) {action in
            self.currentRout.removeAll()
            self.routView.isHidden = true
        }
        alert.addAction(tryAnotherTransportType)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

//MARK:- Building Route

extension ViewController {
   
    private func addAnnotations() {
        let startAnn = MKPointAnnotation()
        let finishAnn = MKPointAnnotation()
        startAnn.title = currentRout["from"]?.placemark.title
        startAnn.coordinate = (currentRout["from"]?.placemark.coordinate)!
        finishAnn.title = currentRout["to"]?.placemark.title
        finishAnn.coordinate = (currentRout["to"]?.placemark.coordinate)!
        myMap.showAnnotations([startAnn, finishAnn], animated: true)
    }
    
    private func chooseType() {
        let chosingTransportController = UIAlertController(title: "Transport", message: "Please, choose which transport do you prefer", preferredStyle: .alert)
        let automobile = UIAlertAction(title: "Automobile", style: .default) {action in self.buildRoute(from: self.currentRout["from"]!, to: self.currentRout["to"]!, type: .automobile)}
        let byFoot = UIAlertAction(title: "By foot", style: .default) {action in self.buildRoute(from: self.currentRout["from"]!, to: self.currentRout["to"]!, type: .walking)}
        let transit = UIAlertAction(title: "Transit", style: .default) {action in self.buildRoute(from: self.currentRout["from"]!, to: self.currentRout["to"]!, type: .transit)}
        chosingTransportController.addAction(automobile)
        chosingTransportController.addAction(transit)
        chosingTransportController.addAction(byFoot)
        present(chosingTransportController, animated: true)
    }
    
    func buildRoute(from: MKMapItem, to: MKMapItem, type: MKDirectionsTransportType) {
        let directionRequest = MKDirectionsRequest()
        directionRequest.destination = to
        directionRequest.source = from
        directionRequest.transportType = .any
        directionRequest.requestsAlternateRoutes = true
        addAnnotations()
        let directions = MKDirections(request: directionRequest)
        directions.calculate(){(response, error) -> Void in
            guard let response = response else {self.present(error: error)
                return}
            for index in response.routes.indices where index < 3 {
                self.myMap.add(response.routes[index].polyline, level: MKOverlayLevel.aboveRoads)
            }
            if let region = response.routes.first?.polyline.boundingMapRect {self.myMap.setRegion(MKCoordinateRegionForMapRect(region), animated: true)}
        }
    }
}

//MARK:- Choosing colors to routes

extension ViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = colors.removeFirst()
        render.lineWidth = 3.0
        return render
    }
}
