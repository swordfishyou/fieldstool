//
//  Polygon.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct Polygon: Geometry {
    var coordinates: [CLLocationCoordinate2D]
    var interiorPolygons: [Polygon]?
    
    var shape: Shape {
        let polygons = self.interiorPolygons?.map { MKPolygon(coordinates: $0.coordinates,
                                                              count: $0.coordinates.count,
                                                              interiorPolygons: nil) }
        return MKPolygon(coordinates: self.coordinates, count: self.coordinates.count, interiorPolygons: polygons)
    }
    
    var renderer: Renderer? {
        return MKPolygonRenderer(overlay: self.shape.overlay!)
    }
}
