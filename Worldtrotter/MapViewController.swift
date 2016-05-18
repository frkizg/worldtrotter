//
//  MapViewController.swift
//  Worldtrotter
//
//  Created by Zvonimir Grebenar on 15.05.2016..
//  Copyright © 2016. Zvonimir Grebenar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate  {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
       
        //Create MapView
        mapView = MKMapView()
        mapView.delegate = self
    
        
        locationManager = CLLocationManager()
        
        
        //Set it as *the* view for this ViewController
        view = mapView
        
        let  segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: (#selector(MapViewController.mapTypeChanged(_:))), forControlEvents: .ValueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
    
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        let showLocationButton = UIButton(type: .System)
        showLocationButton.setTitle("My location", forState: .Normal)
        showLocationButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(showLocationButton)
        showLocationButton.addTarget(self, action: #selector(MapViewController.showLocationButton(_:)), forControlEvents: .TouchUpInside)
        
        let topButonConstraint = showLocationButton.topAnchor.constraintEqualToAnchor(segmentedControl.bottomAnchor, constant: 8)
        let leadingLocationButtonConstraint = showLocationButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingLocationButtonAnchor = showLocationButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topButonConstraint.active = true
        leadingLocationButtonConstraint.active = true
        trailingLocationButtonAnchor.active = true
        
        
        
        
    }
    
    func showLocationButton (sender: UIButton!){
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Map view has loaded")
    }
    
}