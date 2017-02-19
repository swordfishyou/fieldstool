//
//  Line.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct Line: Geometry {
    var coordinates: [CLLocationCoordinate2D]
    
    var shape: Shape {
        return MKPolyline(coordinates: self.coordinates, count: self.coordinates.count)
    }
    
    var renderer: Renderer? {
        return MKPolylineRenderer(overlay: self.shape.overlay!)
    }
}
