//
//  LocationDetailVC.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 11.11.2024.
//

import UIKit
import MapKit
import CoreLocation
import SwiftAlertView

class LocationDetailVC: UIViewController {

    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtComment: UITextField!
    
    @IBOutlet weak var btnAddPhoto: UIButton!
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var LocationManager = CLLocationManager()
    var selectedLongitude = ""
    var selectedLatitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        addGestureRecognizer()
        
        txtTitle.text = globalSelectedLocation?.title
        txtComment.text = globalSelectedLocation?.subtitle
    }
    
    @IBAction func btnAddPhotoClicked(_ sender: Any) {
    }
    
    
}

extension LocationDetailVC: MKMapViewDelegate , CLLocationManagerDelegate{
    func setupMap() {
        self.mapView.delegate = self
        self.LocationManager.delegate = self
        
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.LocationManager.requestWhenInUseAuthorization()
        self.LocationManager.startUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: Double(globalSelectedLocation!.Latitude) ?? 0.0, longitude: Double(globalSelectedLocation!.Longitude) ?? 0.0)
        annotation.coordinate = location
        annotation.title = globalSelectedLocation?.title ?? ""
        annotation.subtitle = globalSelectedLocation?.subtitle ?? ""
        
        mapView.addAnnotation(annotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: Double(globalSelectedLocation!.Latitude) ?? locations[0].coordinate.latitude, longitude: Double(globalSelectedLocation!.Longitude) ?? locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
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
            annotation.title = ""
            annotation.subtitle = ""
            
            self.selectedLatitude = String(coordinate.latitude)
            self.selectedLongitude = String(coordinate.longitude)
            
            self.mapView.addAnnotation(annotation)
        }
    }}
