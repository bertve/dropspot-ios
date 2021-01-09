//
//  NewSpotMarkerView.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import MapKit

class NewSpotMarkerView: MKMarkerAnnotationView {
    
    static let identifier = "newSpotMarker"
    override var annotation: MKAnnotation? {
        willSet{
            guard (newValue as? NewSpotMarker) != nil else {
                return
            }
            canShowCallout = false
            isDraggable = true
            markerTintColor = Theme.globalColorSheme().secondaryColor
            let imageMarker =  UIImage(named: "flagMarker")
            glyphImage = imageMarker
            glyphTintColor = Theme.globalColorSheme().primaryColor
        }
    }
}
