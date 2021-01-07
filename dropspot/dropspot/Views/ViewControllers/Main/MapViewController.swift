//
//  MapViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 04/01/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet private var mapView: MKMapView!

    private let spotRepository = SpotRepository()
    private var markers = [SpotMarker]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(SpotMarkerView.self, forAnnotationViewWithReuseIdentifier: SpotMarkerView.identifier)
        
        spotRepository.fetchSpots(completion: { res in
            switch (res){
            case .success(let spots):
                self.updateMap(with: spots)
            case .failure(let error):
                self.handleFailure(error: error)
            }
        })
    }
    
    private func updateMap(with spots: [Spot]){
        mapView.removeAnnotations(markers)
        markers = [SpotMarker]()
        spots.forEach{ spot in
            markers.append(SpotMarker(spotId: spot.id, spotName: spot.name, lat: spot.latitude, long: spot.longitude))
        }
        mapView.addAnnotations(markers)
    }
    
    private func handleFailure(error: Error){
        showSnackBar(message: error.localizedDescription)
    }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SpotMarker else {
            return nil
        }
        
        var view : SpotMarkerView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: SpotMarkerView.identifier) as? SpotMarkerView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = SpotMarkerView(annotation: annotation, reuseIdentifier: SpotMarkerView.identifier)
        }
        
        return view
    }
    
    func mapView(
      _ mapView: MKMapView,
      annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl
    ) {
      guard let marker = view.annotation as? SpotMarker else {
        return
      }

      let launchOptions = [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
      ]
        marker.mapItem?.openInMaps(launchOptions: launchOptions)
    }

}

private extension MKMapView {
    func centerMapwithLocation(_ loc: CLLocation,
                               radius: CLLocationDistance){
        let coordinateRegion = MKCoordinateRegion (
            center: loc.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        setRegion(coordinateRegion, animated: true)
    }
}
