//
//  SpotMarker.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 07/01/2021.
//

import Foundation
import MapKit
import Contacts

class SpotMarker: NSObject, MKAnnotation {
    var spotId: Int
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(spotId: Int,
         spotName: String,
         lat: Double,
         long: Double) {
        self.spotId = spotId
        self.title = spotName
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        super.init()
    }
    
    var mapItem: MKMapItem? {
      let placemark = MKPlacemark(coordinate: coordinate)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
}
