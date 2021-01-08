//
//  MapViewController.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 04/01/2021.
//

import UIKit
import MapKit
import CoreLocation
import MaterialComponents
import FloatingPanel

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, FloatingPanelControllerDelegate{

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet var fabBtn: MDCFloatingButton!

    private let spotRepository = SpotRepository()
    private var markers = [SpotMarker]()
    private var locationManager: CLLocationManager!
    private var currentLocationMarker: CurrentLocationMarker? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup fab
        fabBtn.accessibilityLabel = "Create"
        fabBtn.minimumSize = CGSize(width: 32, height: 32)
        Theme.applyThemeToFab(fabBtn)
        
        // setup custom markers
        mapView.delegate = self
        mapView.register(SpotMarkerView.self, forAnnotationViewWithReuseIdentifier: SpotMarkerView.identifier)
        mapView.register(CurrentLocationMarkerView.self, forAnnotationViewWithReuseIdentifier: CurrentLocationMarkerView.identifier)
        
        // load spots
        spotRepository.fetchSpots(completion: { res in
            switch (res){
            case .success(let spots):
                self.updateMap(with: spots)
            case .failure(let error):
                self.handleFailure(error: error)
            }
        })
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determineCurrentLocation()
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

    // loading custom markers
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        switch (annotation) {
        case let spotMarker as SpotMarker:
            return handleDequeuingSpotMarker(annotation: spotMarker)
        case let currentLocaionMarker as CurrentLocationMarker:
            return handleDequeuingCurrentLocationMarker(annotation: currentLocaionMarker)
        default:
            return nil
        }
    }
    
    private func handleDequeuingSpotMarker(annotation: SpotMarker) -> SpotMarkerView {
        var view : SpotMarkerView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: SpotMarkerView.identifier) as? SpotMarkerView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = SpotMarkerView(annotation: annotation, reuseIdentifier: SpotMarkerView.identifier)
        }
        
        return view
    }
    
    private func handleDequeuingCurrentLocationMarker(annotation: CurrentLocationMarker) -> CurrentLocationMarkerView{
        var view : CurrentLocationMarkerView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: CurrentLocationMarkerView.identifier) as? CurrentLocationMarkerView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = CurrentLocationMarkerView(annotation: annotation, reuseIdentifier: CurrentLocationMarkerView.identifier)
        }
        
        return view
    }
    
    // navigate to selected spot
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
    
    // current loc
    //MARK:- CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // get current location
        let mUserLocation:CLLocation = locations[0] as CLLocation

        // draw current location if not same loc
        if let marker = currentLocationMarker {
            mapView.removeAnnotation(marker)
        } else {
            // init center current location
            mapView.centerMapwithLocation(mUserLocation, radius: 1000)
        }
        
        currentLocationMarker = CurrentLocationMarker(coordinate: mUserLocation.coordinate)
        mapView.addAnnotation(currentLocationMarker!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: adding spot
    @IBAction func fabBtnPressed(_ sender: Any) {
        // setup floating panel
        let fpc = FloatingPanelController()
        fpc.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpcContent") as? ContentFloatingPanelViewController else {
            return
        }
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self, animated: true)
        fabBtn.visibility = .gone
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
