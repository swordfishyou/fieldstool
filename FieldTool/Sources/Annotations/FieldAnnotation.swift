//
//  FieldAnnotation.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

class FieldAnnotation: MKPointAnnotation, GeometryAnnotation {
    typealias Object = Field
    var object: Field
    
    required init(object: Field) {
        self.object = object
        super.init()
        self.title = object.title
        self.subtitle = object.subtitle
    }
    
    func set(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
