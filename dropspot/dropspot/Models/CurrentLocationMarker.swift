//
//  CurrentLocationMarker.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 07/01/2021.
//

import MapKit

class CurrentLocationMarker: NSObject, MKAnnotation {
    var title: String? = "You"
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
