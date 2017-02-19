//
//  Geometry.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/15/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol Geometry: CoordinatesCollection {
    var shape: Shape { get }
    var renderer: Renderer? { get }
    var center: CLLocationCoordinate2D { get }
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool
    func contains(geometry: Geometry) -> Bool
    func intersects(geometry: Geometry) -> Bool
}

extension Geometry {
    var center: CLLocationCoordinate2D {
        return self.shape.annotation.coordinate
    }
    
    func contains(geometry: Geometry) -> Bool {
        for coordinate in self.coordinates {
            if !geometry.contains(coordinate: coordinate) {
                return false
            }
        }
        return true
    }
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        guard let renderer = self.renderer else {
            return false
        }
        return renderer.contains(coordinate: coordinate)
    }
    
    func intersects(geometry: Geometry) -> Bool {
        for coordinate in self.coordinates {
            if geometry.contains(coordinate: coordinate) {
                return true
            }
        }
        return false
    }
}
