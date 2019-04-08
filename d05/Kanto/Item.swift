//
//  Item.swift
//  Kanto
//
//  Created by Denis SEMERYCH on 12/1/18.
//  Copyright © 2018 Denis SEMERYCH. All rights reserved.
//

import Foundation
import MapKit

class Item: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let locationName: String
    var subtitle: String? {return locationName}
    
    init(adress: String, name: String, coordinate: CLLocationCoordinate2D) {
        title = name
        locationName = adress
        self.coordinate = coordinate
    }
}
