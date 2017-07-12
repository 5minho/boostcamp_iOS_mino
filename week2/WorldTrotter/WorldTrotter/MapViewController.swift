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
    var latitudeTextFeild : UITextField!
    var longitudeTextFeild : UITextField!
    var setAnnotationButton : UIButton!
    var tourLocationsPinned : UIButton!
    let locationManager: CLLocationManager = CLLocationManager()
    var currentPinIndex = 0
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
    
        mapView = MKMapView()
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        
        latitudeTextFeild = UITextField()
        longitudeTextFeild = UITextField()
        latitudeTextFeild.placeholder = "위도 입력: "
        longitudeTextFeild.placeholder = "경도 입력: "
        
        setAnnotationButton = UIButton(type: .system)
        setAnnotationButton.setTitle("핀 추가", for: .normal)
        setAnnotationButton.addTarget(self, action: #selector(addAnnotation(button:)), for: .touchUpInside)
        setAnnotationButton.backgroundColor = UIColor.darkGray
        
        tourLocationsPinned = UIButton(type: .system)
        tourLocationsPinned.setTitle("핀 순회", for: .normal)
        tourLocationsPinned.addTarget(self, action: #selector(tour(button:)), for: .touchUpInside)
        tourLocationsPinned.backgroundColor = UIColor.green
        
        
        segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged) , for: .valueChanged)
        

        currentPositionButton = UIButton(type: .system)
        currentPositionButton.backgroundColor = UIColor.gray
        currentPositionButton.setTitle("현재위치", for: UIControlState.normal)
        currentPositionButton.addTarget(self, action: #selector(annotateCurrentPositionAndZoom), for: .touchUpInside)
        
        view.addSubview(setAnnotationButton)
        view.addSubview(latitudeTextFeild)
        view.addSubview(longitudeTextFeild)
        view.addSubview(mapView)
        view.addSubview(segmentedControl)
        view.addSubview(currentPositionButton)
        view.addSubview(tourLocationsPinned)
        
        createConstraint()
    }
   
    
    func createConstraint() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        currentPositionButton.translatesAutoresizingMaskIntoConstraints = false
        latitudeTextFeild.translatesAutoresizingMaskIntoConstraints = false
        longitudeTextFeild.translatesAutoresizingMaskIntoConstraints = false
        setAnnotationButton.translatesAutoresizingMaskIntoConstraints = false
        tourLocationsPinned.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        
        NSLayoutConstraint(item: mapView, attribute: .top, relatedBy: .equal, toItem: segmentedControl, attribute: .bottom, multiplier: 1, constant: 8.0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .leading, relatedBy: .equal, toItem: segmentedControl, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .width, relatedBy: .equal, toItem: segmentedControl, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.625, constant: 0).isActive = true
        
        NSLayoutConstraint(item: currentPositionButton, attribute: .top, relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1, constant: 8.0).isActive = true
        NSLayoutConstraint(item: currentPositionButton, attribute: .leading, relatedBy: .equal, toItem: mapView, attribute: .leading, multiplier: 1 , constant: 0.0).isActive = true
        NSLayoutConstraint(item: currentPositionButton, attribute: .width, relatedBy: .equal, toItem: mapView, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        NSLayoutConstraint(item: currentPositionButton, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: -8.0).isActive = true
        
        latitudeTextFeild.topAnchor.constraint(equalTo: currentPositionButton.topAnchor).isActive = true
        latitudeTextFeild.leadingAnchor.constraint(equalTo: currentPositionButton.trailingAnchor, constant: 8.0).isActive = true
        latitudeTextFeild.trailingAnchor.constraint(equalTo: mapView.trailingAnchor).isActive = true
        
        longitudeTextFeild.centerYAnchor.constraint(equalTo: currentPositionButton.centerYAnchor).isActive = true
        longitudeTextFeild.leadingAnchor.constraint(equalTo: latitudeTextFeild.leadingAnchor).isActive = true
        longitudeTextFeild.heightAnchor.constraint(equalTo: latitudeTextFeild.heightAnchor).isActive = true
        longitudeTextFeild.widthAnchor.constraint(equalTo: latitudeTextFeild.widthAnchor).isActive = true
        
        setAnnotationButton.leadingAnchor.constraint(equalTo: latitudeTextFeild.leadingAnchor).isActive = true
        setAnnotationButton.bottomAnchor.constraint(equalTo: currentPositionButton.bottomAnchor).isActive = true
        setAnnotationButton.widthAnchor.constraint(equalTo: latitudeTextFeild.widthAnchor, multiplier: 0.4).isActive = true
        
        tourLocationsPinned.trailingAnchor.constraint(equalTo: mapView.trailingAnchor).isActive = true
        tourLocationsPinned.widthAnchor.constraint(equalTo: setAnnotationButton.widthAnchor).isActive = true
        tourLocationsPinned.bottomAnchor.constraint(equalTo: setAnnotationButton.bottomAnchor).isActive = true
    }

    func locationManagerConfiguration() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    /* 잘못된 위, 경도 값 입력시 크래쉬 */
    @discardableResult func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span : Double)
    -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegionMake(pLocation, spanValue)
        mapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func addAnnotation(button: UIButton) {
        //예외처리 필요
        let latitudeValue = CLLocationDegrees(latitudeTextFeild.text!)!
        let longitudeValue = CLLocationDegrees(longitudeTextFeild.text!)!
        setAnnotation(latitude:latitudeValue , longitude: longitudeValue, delta: 1, title: "추가해야한", subtitle: "추가해야함")
    }
    
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees,
                       delta span : Double, title strTitle: String, subtitle strSubtitle : String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        annotation.title = "strTitle"
        annotation.subtitle = "strSubTitle"
        mapView.addAnnotation(annotation)
    }
    
    /* 핀이 없을 경우 크래쉬가 나는 것 해결 */
    /* 핀이 있어도 제대로 순회하지 않음 */
    func tour(button: UIButton) {
        currentPinIndex %= (mapView.annotations.count - 1)
        print(currentPinIndex)
        
        // goLocation 메서드에 @discardableResult추가로 _ = 해결
        goLocation(latitude: mapView.annotations[currentPinIndex].coordinate.latitude, longitude: mapView.annotations[currentPinIndex].coordinate.longitude, delta: 1)
        currentPinIndex += 1
    }
    
    /* 사용자가 위치사용을 허용하지 않았을 때의 예외처리 */
    func annotateCurrentPositionAndZoom() {
        if CLLocationManager.locationServicesEnabled() {
            mapView.setUserTrackingMode(.follow, animated: true)
        }
    }
}

