//
//  SpotMarkerView.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 07/01/2021.
//

import MapKit

class SpotMarkerView: MKMarkerAnnotationView {
    
    static let identifier = "spotMarker"
    override var annotation: MKAnnotation? {
        willSet{
            guard (newValue as? SpotMarker) != nil else {
                return
            }
            
            canShowCallout = true
            
            let mapsButton = UIButton(frame: CGRect(
              origin: CGPoint.zero,
              size: CGSize(width: 32, height: 32)))
            let imageAccessoryView = UIImage(named: "map")
            mapsButton.setBackgroundImage(imageAccessoryView, for: .normal)
            rightCalloutAccessoryView = mapsButton
            clusteringIdentifier = SpotMarkerView.identifier

            markerTintColor = Theme.globalColorSheme().primaryColor
            let imageMarker =  UIImage(named: "spotMarker")
            glyphImage = imageMarker
        }
    }
}
