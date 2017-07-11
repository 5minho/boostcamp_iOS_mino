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
    var segmentedControl: UISegmentedControl!
    var currentPositionButton : UIButton!
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        print("loadView")
        createMapView()
        createSegmentedControl()
        createCurrentPositionButton()
        createConstraint()
        
    }
    
    func createConstraint() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        currentPositionButton.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        
        NSLayoutConstraint(item: mapView, attribute: .top, relatedBy: .equal, toItem: segmentedControl, attribute: .bottom, multiplier: 1, constant: 8.0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .leading, relatedBy: .equal, toItem: segmentedControl, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .width, relatedBy: .equal, toItem: segmentedControl, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 3/4, constant: 0).isActive = true
        
        NSLayoutConstraint(item: currentPositionButton, attribute: .top, relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1, constant: 8.0).isActive = true
        NSLayoutConstraint(item: currentPositionButton, attribute: .leading, relatedBy: .equal, toItem: mapView, attribute: .leading, multiplier: 1 , constant: 0.0).isActive = true
        NSLayoutConstraint(item: currentPositionButton, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: -8.0).isActive = true
    }

    func locationManagerConfiguration() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func createMapView() {
        self.mapView = MKMapView()
        self.mapView.delegate = self
        self.mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        self.view.addSubview(mapView)
    }
    
    func createSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged) , for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    func createCurrentPositionButton() {
        currentPositionButton = UIButton()
        currentPositionButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        currentPositionButton.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        currentPositionButton.backgroundColor = UIColor.yellow
        currentPositionButton.setTitle("현재위치", for: UIControlState.normal)
        currentPositionButton.addTarget(self, action: #selector(annotateCurrentPositionAndZoom), for: .touchUpInside)
        view.addSubview(currentPositionButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerConfiguration()
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
            mapView.setUserTrackingMode(.follow, animated: true)
        }
    }
}

