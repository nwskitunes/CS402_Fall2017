//
//  MapLocation+CoreDataProperties.swift
//  Maps9_19
//
//  Created by Wade Morris on 10/28/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import Foundation
import CoreData


extension MapLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MapLocation> {
        return NSFetchRequest<MapLocation>(entityName: "MapLocation");
    }

    @NSManaged public var descriptionStr: String?
    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
