//
//  LocationController.swift
//  Maps9_19
//
//  Created by Wade Morris on 11/28/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import Foundation
import CoreLocation

class LocationController:NSObject, CLLocationManagerDelegate {
    
    static let sharedLocationController:LocationController = LocationController()
    static var curr:CLLocation? = nil
    static let locMan:CLLocationManager = CLLocationManager()
    
    class func startGPS(){
        locMan.delegate = sharedLocationController
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        locMan.startUpdatingLocation()
        locMan.requestAlwaysAuthorization()
    }
    
    class func stopGPS(){
        locMan.stopUpdatingLocation()
    }
    
    class func currentLoc() -> CLLocationCoordinate2D{
        if(curr != nil){
            return (curr?.coordinate)!
        }
        else{
            return CLLocationCoordinate2DMake(0.0, 0.0)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationController.curr = locations[0]
    }
    
}
