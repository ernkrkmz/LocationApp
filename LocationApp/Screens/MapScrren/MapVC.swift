//
//  MapVC.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 10.11.2024.
//

import UIKit
import MapKit
import CoreLocation
import SwiftAlertView

class MapVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var LocationManager = CLLocationManager()
    var selectedLongitude = ""
    var selectedLatitude = ""
    
    var titleText = ""
    var subtitleText = ""
    
    var locationList : [LocationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            self.locationList = await FirebaseManager().fetchLocations() ?? []
            guard locationList.count > 0 else {
                print("locationlist empty!!")
                return
            }
            for location in locationList {
                let annotation = MKPointAnnotation()
                annotation.title = location.title
                annotation.subtitle = location.subtitle
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.Latitude) ?? 0, longitude: Double(location.Longitude) ?? 0)
                mapView.addAnnotation(annotation)
            }
            mapView.reloadInputViews()
        }
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
            annotation.title = ""
            annotation.subtitle = ""
            
            self.selectedLatitude = String(coordinate.latitude)
            self.selectedLongitude = String(coordinate.longitude)
            
            self.mapView.addAnnotation(annotation)
        }
    }
    // MARK: Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        
        if pinView == nil {
            
            pinView = MKPinAnnotationView(annotation: annotation , reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            
            let button = UIButton(type: .contactAdd)
            pinView?.rightCalloutAccessoryView = button
            
        }else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    // MARK: Save button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        SwiftAlertView.show(title: "Save Location", message: "", buttonTitles: "Cancel","OK") {
            alertView in
            
            alertView.titleLabel.textColor = .white
            alertView.messageLabel.textColor = .white
            alertView.separatorColor = .white
            alertView.style = .dark
            alertView.addTextField { textField in
                textField.placeholder = "Title"
            }
            alertView.addTextField { textField in
                textField.placeholder = "Comment"
            }
            alertView.isDismissOnActionButtonClicked = false
            alertView.isEnabledValidationLabel = true
            
        }
        .onButtonClicked { alertView, btnIndex in
            guard let title = alertView.textField(at: 0)?.text else { return }
            let subtitle = alertView.textField(at: 1)?.text ?? ""
            
            
            Task {
                await FirebaseManager().saveLocation(titleText: title, subtitleText: subtitle, longitude: self.selectedLongitude, latitude: self.selectedLatitude)
                alertView.dismiss()
                SwiftAlertView.show(title:"Location Saved", buttonTitles: "OK") { alertView in
                    alertView.style = .dark
                }
            }
            
        }
    }
    
}


