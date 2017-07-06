//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 오민호 on 2017. 7. 3..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var currentPositionButton : UIButton!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        print("loadView")
        determineCurrentLocation()
        createMapView()
        createSegmentedControl()
        createCurrentPositionButton()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations location: [AnyObject]!) {
        guard let location = location.last as? CLLocation else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
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
    
    func createMapView() {
        self.mapView = MKMapView()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.isZoomEnabled = true
        view = mapView
    }
    
    func createSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged) , for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let margin = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margin.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
    
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func createCurrentPositionButton() {
        currentPositionButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: view.frame.height / 8))
        currentPositionButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        currentPositionButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        currentPositionButton.setTitle("현재위치", for: UIControlState.normal)
        currentPositionButton.translatesAutoresizingMaskIntoConstraints = false
        currentPositionButton.addTarget(self, action: #selector(annotateCurrentPositionAndZoom), for: .touchUpInside)
        view.addSubview(currentPositionButton)
        NSLayoutConstraint(item: currentPositionButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0.8, constant: 0.0).isActive = true
        NSLayoutConstraint(item: currentPositionButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing , multiplier: 0.8 , constant: 0.0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func annotateCurrentPositionAndZoom() {
        if CLLocationManager.locationServicesEnabled() {
            //print("asd")
            locationManager.startUpdatingLocation()
        }
    }
}

