//
//  FieldsMapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct FieldsMapViewDataSource: MapViewDataSource {
    var fields: [Field]
    private var polygons: [Polygon]? = nil
    
    init(fields: [Field]) {
        self.fields = fields
        let parser = WKTParser()
        let serializer = WKTPolygonSerialization()
        self.polygons = fields.map { parser.parse($0.geometryString) }
                              .flatMap { $0 }
                              .map { serializer.geometry(from: $0) }
                              .flatMap { $0 }
    }
    
    func overlays() -> [MKOverlay]? {
        guard let polygons = self.polygons else {
            return nil
        }
        
        return polygons.map { $0.shape }
    }
    
    func annotations() -> [MKAnnotation]? {
        guard let polygons = self.polygons else {
            return nil
        }
        
        var annotations = self.fields.map { FieldAnnotation(field: $0) }
        for idx in 0..<annotations.count {
            let annotation = annotations[idx]
            let polygon = polygons[idx]
            annotation.coordinate = polygon.center
        }
        
        return annotations
    }
    
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer? {
        guard let polygons = self.polygons else {
            return nil
        }
        
        for idx in 0..<polygons.count {
            let polygon = polygons[idx]
            if MKMapPointEqualToPoint(MKMapPointForCoordinate(polygon.center), MKMapPointForCoordinate(overlay.coordinate)) {
                let renderer = polygon.renderer
                renderer?.apply(self.fields[idx].styles)
                return renderer
            }
        }
        
        return nil
    }
    
    func boundingRect() -> MKMapRect {
        var flyTo = MKMapRectNull
        if let overlays = self.overlays() {
            for overlay in overlays {
                flyTo = flyTo.union(overlay.boundingMapRect)
            }
        }
        return flyTo
    }
}
