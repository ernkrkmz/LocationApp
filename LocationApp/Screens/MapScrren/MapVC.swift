//
//  MapVC.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 10.11.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var LocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMap()
        
        addGestureRecognizer()
        
    }
    

    
}

extension MapVC {
    
    func setupMap() {
        self.mapView.delegate = self
        self.LocationManager.delegate = self
        
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.LocationManager.requestWhenInUseAuthorization()
        self.LocationManager.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }
//    MARK: Gesture Recognizer
    func addGestureRecognizer() {
        
        let getGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gesture: )))
        getGestureRecognizer.minimumPressDuration = 2
        self.mapView.addGestureRecognizer(getGestureRecognizer)
    }
    
    @objc func chooseLocation(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let location = gesture.location(in: self.mapView)
            let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Annotation 123"
            self.mapView.addAnnotation(annotation)
        }
    }
    
}


