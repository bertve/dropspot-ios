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
            
            let detailButton = UIButton(frame: CGRect(
                                            origin: CGPoint.zero,
                                            size: CGSize(width: 32, height: 32)))
            let leftImgAccessoryView = UIImage(named: "park")
            detailButton.setBackgroundImage(leftImgAccessoryView, for: .normal)
            leftCalloutAccessoryView  = detailButton
            
            let mapsButton = UIButton(frame: CGRect(
              origin: CGPoint.zero,
              size: CGSize(width: 32, height: 32)))
            let imageAccessoryView = UIImage(named: "map")
            mapsButton.setBackgroundImage(imageAccessoryView, for: .normal)
            mapsButton.accessibilityIdentifier = "navigate"
            rightCalloutAccessoryView = mapsButton
            
            clusteringIdentifier = SpotMarkerView.identifier

            markerTintColor = Theme.globalColorSheme().secondaryColor
            let imageMarker =  UIImage(named: "spotMarker")
            glyphImage = imageMarker
            glyphTintColor = Theme.globalColorSheme().primaryColor
        }
    }
}
