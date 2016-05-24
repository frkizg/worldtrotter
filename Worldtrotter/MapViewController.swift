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
    
    var locationArray:[MKPointAnnotation]=[]
    var locationArrayindex:Int=0
    
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
        
        var location = MKPointAnnotation()
        
        location.coordinate = CLLocationCoordinate2DMake(39.9, -75.9)
        location.title = "First location"
        location.subtitle = "location 0"
        mapView.addAnnotation(location)
        
        
        locationArray.append(location)
        
        location.coordinate = CLLocationCoordinate2DMake(45.8, 16.24)
        location.title = "Doma"
        location.subtitle = "moja kuća"
        locationArray.append(location)
        
        location.coordinate = CLLocationCoordinate2DMake(45.02, 14.56)
        location.title = "Viksa"
        location.subtitle = "Kuca na Krku"
        locationArray.append(location)
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 50, 50)
        button.backgroundColor = UIColor.grayColor()
        button.setTitle("NextLoc", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(MapViewController.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(button)
        let widthConstraint = button.widthAnchor.constraintEqualToAnchor(nil, constant: 100.0)
        let heightConstraint = button.heightAnchor.constraintEqualToAnchor(nil, constant: 35.0)
        let horizontalConstraint = button.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
        let verticalConstraint = button.bottomAnchor.constraintEqualToAnchor(self.bottomLayoutGuide.topAnchor, constant: -28.0)
        NSLayoutConstraint.activateConstraints([widthConstraint, heightConstraint, horizontalConstraint, verticalConstraint])
        
    }
    
    func buttonAction(sender:UIButton!) {
       
        print("Button tapped \(locationArrayindex)")
        mapView.showAnnotations([locationArray[locationArrayindex]], animated: true)
        locationArrayindex = (locationArrayindex + 1)%3
    
    }
    
}