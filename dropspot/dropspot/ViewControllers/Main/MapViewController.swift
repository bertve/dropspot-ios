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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, FloatingPanelControllerDelegate, ContentFloatingPanelDelegate {

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet var fabBtn: MDCFloatingButton!

    private let spotRepository = SpotRepository()
    private var markers = [SpotMarker]()
    private var locationManager: CLLocationManager!
    private var currentLocationMarker: CurrentLocationMarker?
    private var newSpotMarker: NewSpotMarker?
    
    private var fpc: FloatingPanelController?
    private var fpcContent: ContentFloatingPanelViewController?
    
    var delegate: MapDelegate?
    
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
        mapView.register(NewSpotMarkerView.self, forAnnotationViewWithReuseIdentifier: NewSpotMarkerView.identifier)
        
        // setup long press add new spot marker
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressMap))
        longPressGestureRecogniser.minimumPressDuration = 0.2
        mapView.addGestureRecognizer(longPressGestureRecogniser)
        
        // load spots
        spotRepository.fetchSpots { res in
            switch (res){
            case .success(let spots):
                self.updateMap(with: spots)
            case .failure(let error):
                self.handleFailure(error: error)
            }
        }
        
        // setup fpc
        fpc = FloatingPanelController()
        fpc!.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpcContent") as? ContentFloatingPanelViewController else {
            return
        }
        fpcContent = contentVC
        fpcContent!.delegate = self
        fpc!.set(contentViewController: fpcContent)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determineCurrentLocation()
    }
    
    private func updateMap(with spots: [Spot]){
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.markers)
            self.markers = [SpotMarker]()
            spots.forEach{ spot in
                self.markers.append(SpotMarker(spotId: spot.id, spotName: spot.name, lat: spot.latitude, long: spot.longitude))
            }
            self.mapView.addAnnotations(self.markers)
        }
    }
    
    private func handleFailure(error: Error){
        showSnackBar(message: error.localizedDescription)
    }

    // loading custom markers
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        switch (annotation) {
        case let spotMarker as SpotMarker:
            return handleDequeuingSpotMarker(annotation: spotMarker)
        case let currentLocationMarker as CurrentLocationMarker:
            return handleDequeuingCurrentLocationMarker(annotation: currentLocationMarker)
        case let newSpotMarker as NewSpotMarker:
            return handleDequeuingNewSpotMarker(annotation: newSpotMarker)
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
    
    private func handleDequeuingNewSpotMarker(annotation: NewSpotMarker) -> NewSpotMarkerView{
        var view : NewSpotMarkerView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: NewSpotMarkerView.identifier) as? NewSpotMarkerView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = NewSpotMarkerView(annotation: annotation, reuseIdentifier: CurrentLocationMarkerView.identifier)
        }
        
        return view
    }
    
    
    // navigate to selected spot or spotdetail
    func mapView(
      _ mapView: MKMapView,
      annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl
    ) {
      guard let marker = view.annotation as? SpotMarker else {
        return
      }
        
        if control.accessibilityIdentifier == "navigate" {
            let launchOptions = [
              MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
            ]
              marker.mapItem?.openInMaps(launchOptions: launchOptions)
        } else {
            if let delegate = delegate {
                delegate.spotMarkerClicked(spotId: marker.spotId)
            }
        }

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
        openFPC()
    }
    
    private func openFPC(){
        fpc!.addPanel(toParent: self, animated: true)
        fabBtn.visibility = .gone
    }

    func exitFPCClicked(){
        fabBtn.visibility = .visible
        fpc!.removePanelFromParent(animated: true)
        fpcContent?.latitude = nil
        fpcContent?.longitude = nil
        if let marker = newSpotMarker {
            mapView.removeAnnotation(marker)
            newSpotMarker = nil
        }
    }
    
    func addStreetSpot(requestModel: AddStreetSpotRequestModel) {
        print(requestModel)
        spotRepository.addStreetSpot(requestModel: requestModel){ res in
            switch (res){
            case .success(let spot):
                self.handleAddSpotSuccess(spot)
            case .failure(let error):
                self.handleAddSpotFailure(error)
            }
        }
        
    }
    
    func addParkSpot(requestModel: AddParkSpotRequestModel){
        print(requestModel)
        spotRepository.addParkSpot(requestModel: requestModel){ res in
            switch (res){
            case .success(let spot):
                self.handleAddSpotSuccess(spot)
            case .failure(let error):
                self.handleAddSpotFailure(error)
            }
        }
    }
    
    private func handleAddSpotFailure(_ error: Error){
        showSnackBar(message: "Add Failed: " + error.localizedDescription)
    }
    
    private func handleAddSpotSuccess(_ spot: Spot){
        DispatchQueue.main.async {
            self.exitFPCClicked()
            self.spotRepository.saveSpotInLocalDir(spot: spot)
            let spotMarker = SpotMarker(spotId: spot.id, spotName: spot.name, lat: spot.latitude, long: spot.longitude)
            self.mapView.addAnnotation(spotMarker)
            self.fpcContent?.clearFields()
        }
    }
    
    @objc private func handleLongPressMap(gestureRecogniser: UIGestureRecognizer){
        if fabBtn.visibility == .gone {
            guard gestureRecogniser.state == .began else {
                return
            }
            
            let touched = gestureRecogniser.location(in: mapView)
            let mapCoordinate : CLLocationCoordinate2D = mapView.convert(touched, toCoordinateFrom: mapView)
            
            fpcContent?.latitude = mapCoordinate.latitude
            fpcContent?.longitude = mapCoordinate.longitude
            
            if let marker = newSpotMarker {
                mapView.removeAnnotation(marker)
            }
            
            newSpotMarker = NewSpotMarker(coordinate:mapCoordinate)
            mapView.addAnnotation(newSpotMarker!)
        }
    }
    
    // marker dragged new marker coordinates change
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard (view as? NewSpotMarkerView) != nil else {
            return
        }
        
        if let annotation = view.annotation {
            let coordinate = annotation.coordinate
            fpcContent?.latitude = coordinate.latitude
            fpcContent?.longitude = coordinate.longitude
        }
    }
    
    deinit {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
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
