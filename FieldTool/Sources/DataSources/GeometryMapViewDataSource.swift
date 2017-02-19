//
//  GeometryMapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol GeometryMapViewDataSource: MapViewDataSource {
    associatedtype Annotation: GeometryAnnotation
    associatedtype Object: GeometryContainer
    
    var geometries: [Geometry] { get }
    var objects: [Object] { get }
}

extension GeometryMapViewDataSource where Self.Annotation.Object == Self.Object {
    var overlays: [MKOverlay] {
        return self.geometries.map { $0.shape.overlay }.flatMap { $0 }
    }
    
    var annotations: [MKAnnotation] {
        var annotations = [MKAnnotation]()
        for idx in 0..<self.geometries.count {
            let annotation = Annotation(object: self.objects[idx])
            annotation.set(coordinate: self.geometries[idx].center)
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    var boundingRect: MKMapRect {
        return self.geometries.map { $0.shape.mapRect }.reduce(MKMapRectNull) { $0.union(with: $1) }
    }
    
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer? {
        for idx in 0..<self.geometries.count {
            let geometry = self.geometries[idx]
            if MKMapPointEqualToPoint(MKMapPointForCoordinate(geometry.center), MKMapPointForCoordinate(overlay.coordinate)) {
                let renderer = geometry.renderer
                renderer?.apply(self.objects[idx].style)
                return renderer?.overlayRenderer
            }
        }
        
        return nil
    }
}
