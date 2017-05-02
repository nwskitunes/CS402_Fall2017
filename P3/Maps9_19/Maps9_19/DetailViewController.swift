//
//  DetailViewController.swift
//  Maps9_19
//
//  Created by Wade Morris on 9/20/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var mapView:MKMapView?
    var tableView:UITableView?
    let locationManager = CLLocationManager()
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButton(_ sender: AnyObject) {
        let titleString:String = titleTextField.text!
        let descriptionString:String = descriptionTextField.text!
        let mapPin: MapPin = MapPin(title: titleString, subtitle: descriptionString, coordinate: LocationController.currentLoc())
        
        DatabaseController.saveContext()
        
        BuildingController.addingBuildings(building: mapPin)
        self.dismiss(animated: true, completion: nil)
    }
}
