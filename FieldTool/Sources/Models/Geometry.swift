//
//  Geometry.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/15/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol Geometry: CoordinatesCollection {
    associatedtype Shape: MKShape
    associatedtype ShapeRenderer: MKOverlayRenderer
    
    var shape: Shape { get }
    var renderer: ShapeRenderer? { get }
    var center: CLLocationCoordinate2D { get }
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool
    func contains<T : Geometry>(geometry: T) -> Bool
    func intersects<T : Geometry>(geometry: T) -> Bool
}

extension Geometry {
    func contains<T : Geometry>(geometry: T) -> Bool {
        for coordinate in self.coordinates {
            if !geometry.contains(coordinate: coordinate) {
                return false
            }
        }
        
        return true
    }
    
    func intersects<T : Geometry>(geometry: T) -> Bool {
        for coordinate in self.coordinates {
            if geometry.contains(coordinate: coordinate) {
                return true
            }
        }
        
        return false
    }
}

extension Geometry where Self.Shape: MKOverlay {
    var center: CLLocationCoordinate2D {
        return self.shape.coordinate
    }
}

extension Geometry where Self.ShapeRenderer: MKOverlayPathRenderer {
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        guard let renderer = self.renderer else {
            return false
        }
        
        let point = MKMapPointForCoordinate(coordinate)
        return renderer.path.contains(renderer.point(for: point))
    }
}

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
