//
//  Line.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct Line: Geometry {
    typealias Shape = MKPolyline
    typealias ShapeRenderer = MKPolylineRenderer
    
    var coordinates: [CLLocationCoordinate2D]
    
    var shape: MKPolyline {
        return MKPolyline(coordinates: self.coordinates, count: self.coordinates.count)
    }
    
    var renderer: MKPolylineRenderer? {
        return MKPolylineRenderer(polyline: self.shape)
    }
}
