//
//  Polygon.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct Polygon: Geometry {
    typealias Shape = MKPolygon
    typealias ShapeRenderer = MKPolygonRenderer
    
    var coordinates: [CLLocationCoordinate2D]
    var interiorPolygons: [Polygon]?
    
    var shape: MKPolygon {
        let polygons = self.interiorPolygons?.map { $0.shape }
        return MKPolygon(coordinates: self.coordinates, count: self.coordinates.count, interiorPolygons: polygons)
    }
    
    var renderer: MKPolygonRenderer? {
        return MKPolygonRenderer(polygon: self.shape)
    }
}
