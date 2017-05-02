//
//  MapPin.swift
//  Maps9_19
//
//  Created by Wade Morris on 10/28/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
