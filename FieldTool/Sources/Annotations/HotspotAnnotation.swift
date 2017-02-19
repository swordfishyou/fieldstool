//
//  HotspotAnnotation.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

class HotspotAnnotation: MKPointAnnotation, GeometryAnnotation {
    typealias Object = Hotspot
    var object: Hotspot
    
    required init(object: Hotspot) {
        self.object = object
        super.init()
        self.title = object.title
        self.subtitle = object.subtitle
    }
    
    func set(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
