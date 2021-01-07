//
//  CurrentLocationMarkerView.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 07/01/2021.
//

import Foundation

import MapKit

class CurrentLocationMarkerView: MKMarkerAnnotationView {
    
    static let identifier = "currentLocation"
    override var annotation: MKAnnotation? {
        willSet{
            guard (newValue as? CurrentLocationMarker) != nil else {
                return
            }
            
            canShowCallout = false
            
            clusteringIdentifier = CurrentLocationMarkerView.identifier

            markerTintColor = Theme.globalColorSheme().secondaryColor
            let imageMarker =  UIImage(named: "skaterProfileContour")
            glyphImage = imageMarker
            glyphTintColor = Theme.globalColorSheme().primaryColor
        }
    }
}
