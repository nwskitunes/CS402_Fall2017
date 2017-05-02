//
//  TableViewController.swift
//  Maps9_19
//
//  Created by Wade Morris on 10/26/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import MapKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl?
    var mapView:MKMapView?
    var detail:DetailViewController?
    let locationManager = CLLocationManager()
    private var count = 0
    
    var nameList = [String?]()
    var tempList = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: BuildingController.BUILDING_NOTIFICATION_ADDED, object: nil, queue: nil){ notification in
            self.tableView.reloadData()
        }
    }
    
    
    public func updateTable(){
        count += 1
        let fetchRequest: NSFetchRequest<MapLocation> = MapLocation.fetchRequest()
        if(count > 1){
            nameList.append(detail?.name)
        }
        else{
            do{
                let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
                for result in searchResults{
                    nameList.append(result.name)
                }
                
            }
            catch{
                print("ERROR")
            }
        }
        //debugging code for proper number of items in list
        print(nameList.count)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return BuildingController.sharedBuildings().count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        let buildingArray:Array = BuildingController.sharedBuildings()
        let building:MapPin = buildingArray[indexPath.row] as! MapPin
        
        cell.textLabel?.text = building.title
        
        return(cell)
    }
    
    //Segue for getting pin from detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.tableView = self.tableView
        updateTable()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
