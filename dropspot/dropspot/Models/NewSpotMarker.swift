//
//  NewSpotMarker.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation
import MapKit

class NewSpotMarker: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String? = "New Spot"

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
