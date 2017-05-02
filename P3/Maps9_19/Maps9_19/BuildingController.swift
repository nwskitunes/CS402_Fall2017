//
//  BuildingController.swift
//  Maps9_19
//
//  Created by Wade Morris on 11/28/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import CoreData

class BuildingController: NSObject{
    
    public static let BUILDING_NOTIFICATION_ADDED = NSNotification.Name("Added_Building")
    
    static var buildingsArray:Array = Array<MapPin>()
    static let buildingPinClassName:String = String(describing: MapLocation.self)
    
    class func sharedBuildings() -> Array<Any>{
        return buildingsArray
    }
    
    class func addingBuildings(building: MapPin){
    
        BuildingController.buildingsArray.insert(building, at: 0)
        let newBuildingEntity:MapLocation = NSEntityDescription.insertNewObject(forEntityName: buildingPinClassName, into: DatabaseController.getContext()) as! MapLocation
        
        newBuildingEntity.name = building.title
        newBuildingEntity.descriptionStr = building.subtitle
        newBuildingEntity.latitude = building.coordinate.latitude
        newBuildingEntity.longitude = building.coordinate.longitude
        
        NotificationCenter.default.post(name: BUILDING_NOTIFICATION_ADDED , object: building)
    }
    
    class func loadBuildings(){
        //request for json file or pins
        Alamofire.request("https://s3-us-west-2.amazonaws.com/electronic-armory/buildings.json").responseString{
            response in
            
            do{
                let jsonString = response.result.value!
                let jsonData = jsonString.data(using: .utf8)!
                let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! NSArray
                
                for(_, jsonObject) in jsonArray.enumerated(){
                    
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
                    
                    BuildingController.addingBuildings(building: mapPin)
                    
                }
            }
            catch{
                print("error")
            }

    }
    }
}
