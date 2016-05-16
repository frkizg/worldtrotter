//
//  MapViewController.swift
//  Worldtrotter
//
//  Created by Zvonimir Grebenar on 15.05.2016..
//  Copyright © 2016. Zvonimir Grebenar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    var mapView: MKMapView!
    
    override func loadView() {
       
        //Create MapView
        mapView = MKMapView()
        
        
        //Set it as *the* view for this ViewController
        view = mapView
        
        let  segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
    
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Map view has loaded")
    }
    
}