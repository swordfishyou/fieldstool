//
//  Point.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct Point: Geometry {
    var coordinates: [CLLocationCoordinate2D]
    
    var shape: MKShape {
        let shape = MKPointAnnotation()
        shape.coordinate = self.coordinates.first!
        return shape
    }
    
    var center: CLLocationCoordinate2D {
        return self.coordinates.first!
    }
    
    var renderer: MKOverlayRenderer? {
        return nil
    }
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        return false
    }
}
