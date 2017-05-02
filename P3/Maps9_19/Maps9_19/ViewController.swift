//
//  ViewController.swift
//  Maps9_19
//
//  Created by Wade Morris on 9/19/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//


import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {


    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: BuildingController.BUILDING_NOTIFICATION_ADDED, object: nil, queue: nil){ notification in
            let newBuilding:MapPin = notification.object as! MapPin
            self.mapView.addAnnotation(newBuilding)
        }
        
        let buildingsArray:Array = BuildingController.sharedBuildings()
        for(_, current) in buildingsArray.enumerated(){
            let buildingPin:MapPin = current as! MapPin
            mapView.addAnnotation(buildingPin)
        }
        
        let distanceSpan:CLLocationDegrees = 2000
        let currentLocation:CLLocationCoordinate2D = LocationController.currentLoc()
        if(currentLocation.latitude != 0.0){
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(currentLocation, distanceSpan, distanceSpan), animated: true)
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

