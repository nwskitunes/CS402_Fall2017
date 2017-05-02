//
//  ViewController.swift
//  Maps9_19
//
//  Created by Wade Morris on 9/19/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import CoreData
import UIKit
import MapKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {


    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var centerCoordinate:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<MapLocation> = MapLocation.fetchRequest()
        
        //delete core data on load
        do{
            let items = try DatabaseController.getContext().fetch(fetchRequest)
            
            for item in items{
                DatabaseController.getContext().delete(item)
            }
        }
        catch{
            print("error")
        }

        //Sets up the delegates and request for authorization
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.distanceFilter = 0.01
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        self.locationManager.startUpdatingLocation()
        
        //show the user's location
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
        //request for json file or pins
        Alamofire.request("https://s3-us-west-2.amazonaws.com/electronic-armory/buildings.json").responseString{
            response in
            
            do{
                let jsonString = response.result.value!
                let jsonData = jsonString.data(using: .utf8)!
                let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! NSArray
            
                for(index, jsonObject) in jsonArray.enumerated(){
                    
                    let currentLocation:Dictionary = jsonObject as! Dictionary<String, AnyObject>
                    
                    let NAME_PAR = "name"
                    let DESC_PAR = "description"
                    
                    let nameString:String = currentLocation[NAME_PAR] as! String
                    let descriptionString:String = currentLocation[DESC_PAR] as! String
                   
                    let locationString:CLLocationCoordinate2D = CLLocationCoordinate2DMake (currentLocation["location"]?["latitude"] as! CLLocationDegrees,
                    currentLocation["location"]?["longitude"] as! CLLocationDegrees)
                    

                    
                    let mapLocation:MapLocation = NSEntityDescription.insertNewObject(forEntityName: "MapLocation", into: DatabaseController.getContext()) as! MapLocation
                    
                    mapLocation.descriptionStr = descriptionString
                    mapLocation.name = nameString
                    mapLocation.latitude = locationString.latitude
                    mapLocation.longitude = locationString.longitude
                    
                    let mapPin: MapPin = MapPin(title:nameString, subtitle:descriptionString, coordinate: locationString)
                    
                    DatabaseController.saveContext()
                    
                    self.mapView.addAnnotation(mapPin)
                    
                    do{
                        let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
                        print("result: \(searchResults)")
                    }
                    catch{
                        print("ERROR")
                    }
                    
                }
            }
            catch{
                print("error")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Segue for getting pin from detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.mapView = self.mapView
    }
    
    //Location helper function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        //variable to segue pass between detail and main view controllers
        centerCoordinate = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        //set region and stop updating the location
        self.mapView.setRegion(region, animated: true)
        //self.locationManager.stopUpdatingLocation()
    }
    
    //location debugger helper function
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

}

