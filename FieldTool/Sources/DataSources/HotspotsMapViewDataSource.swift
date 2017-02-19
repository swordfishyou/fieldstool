//
//  HotspotsMapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct HotspotsMapViewDataSource: MapViewDataSource {
    var hotspots: [Hotspot]
    private var points: [Point]? = nil
    private var lines: [Line]? = nil
    private var polygons: [Polygon]? = nil
    
    init(hotspots: [Hotspot]) {
        self.hotspots = hotspots
        let parser = WKTParser()
        let wkts = hotspots.map { parser.parse($0.geometryString) }.flatMap { $0 }
        self.points =  self.geometries(from: wkts.filter { $0.name == "POINT" }, with: WKTPointSerialization())
        self.lines = self.geometries(from: wkts.filter { $0.name == "LINESTRING" }, with: WKTLineSerialization())
        self.polygons = self.geometries(from: wkts.filter { $0.name == "POLYGON" }, with: WKTPolygonSerialization())
    }
    
    private func geometries<T: WKTSerizalization>(from wkts: [WKTType], with serializer: T) -> [T.Output] {
        return wkts.map { serializer.geometry(from: $0) }.flatMap { $0 }
    }
    
    func overlays() -> [MKOverlay]? {
        var overlays = [MKOverlay]()
        if let lines = self.lines {
            overlays.append(contentsOf: lines.map { $0.shape })
        }
        if let polygons = self.polygons {
            overlays.append(contentsOf: polygons.map { $0.shape })
        }
        return overlays
    }
    
    func annotations() -> [MKAnnotation]? {
        var centers = [CLLocationCoordinate2D]()
        
        if let points = self.points {
            centers.append(contentsOf: points.map { $0.center })
        }
        
        if let overlays = self.overlays() {
            centers.append(contentsOf: overlays.map { $0.coordinate })
        }
        
        var annotations = self.hotspots.map { HotspotAnnotation(hotspot: $0) }
        for idx in 0..<annotations.count {
            let annotation = annotations[idx]
            annotation.coordinate = centers[idx]
        }
        
        return annotations
    }
    
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer? {
        if let renderer = self.renderer(for: overlay, in: self.lines) {
            return renderer
        }
        
        return self.renderer(for: overlay, in: self.polygons)
    }
    
    private func renderer<T: Geometry>(for overlay: MKOverlay, in geometries: [T]?) -> MKOverlayRenderer? where T.Shape : MKOverlay, T.ShapeRenderer : MKOverlayPathRenderer {
        guard let objects = geometries else {
            return nil
        }
        for object in objects {
            if MKMapPointEqualToPoint(MKMapPointForCoordinate(object.center), MKMapPointForCoordinate(overlay.coordinate)) {
                let renderer = object.renderer
                renderer?.apply(HotspotStyle())
                return renderer
            }
        }
        return nil
    }
    
    func boundingRect() -> MKMapRect {
        var flyTo = MKMapRectNull
        if let points = self.points {
            for point in points {
                let center = MKMapPointForCoordinate(point.center)
                let pointRect = MKMapRectMake(center.x, center.y, 0, 0)
                flyTo = flyTo.union(pointRect)
            }
        }
        
        if let overlays = self.overlays() {
            for overlay in overlays {
                flyTo = flyTo.union(overlay.boundingMapRect)
            }
        }
        
        return flyTo
    }
}
