//
//  FirstViewController.swift
//  Kanto
//
//  Created by Denis SEMERYCH on 12/1/18.
//  Copyright © 2018 Denis SEMERYCH. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    let regionRadius: CLLocationDistance = 250
    let manager = CLLocationManager()
    var resultSearchController: UISearchController?
    
    @IBOutlet private var map: MKMapView!
    
    var place = Item(adress: "96 Boulevard Bessières", name: "42 school, Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8966358, longitude: 2.318433713622695))
    var colors: [UIColor] = [.green, .red, .yellow, .blue, .purple]
    
    @IBAction func showCurrentLocation(_ sender: UIButton) {
        centerMapOnLocation(location: map.userLocation.coordinate)
    }
    
    @IBAction func changeMapStyle(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            map.mapType = .standard
        case 1:
            map.mapType = .hybrid
        case 2:
            map.mapType = .satellite
        default:
            break
        }
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let centerCoordinate = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        map.setRegion(centerCoordinate, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        manager.requestAlwaysAuthorization()
        map.mapType = .standard
        manager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        map.addAnnotation(place)
        centerMapOnLocation(location: place.coordinate)
    }
}

extension FirstViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Item else {return nil}
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let informationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            informationView.annotation = annotation
            view = informationView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .roundedRect)
            view.rightCalloutAccessoryView?.accessibilityLabel = annotation.locationName
            view.animatesWhenAdded = true
            view.markerTintColor = colors.removeFirst()
        }
        return view
    }
}


