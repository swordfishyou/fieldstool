//
//  WKTSerialization.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/16/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

protocol WKTSerizalization {
    associatedtype Output: Geometry
    func geometry(from input: WKTType) -> Output?
}

struct WKTPointSerialization: WKTSerizalization {
    typealias Output = Point
    
    func geometry(from input: WKTType) -> Point? {
        if input.components.count != 1 {
            return nil
        }
        
        guard let component = input.components.first, component.coordinates.count == 1 else {
            return nil
        }
        
        return Point(coordinates: component.coordinates)
    }
}

struct WKTLineSerialization: WKTSerizalization {
    typealias Output = Line
    
    func geometry(from input: WKTType) -> Line? {
        if input.components.count != 1 {
            return nil
        }
        
        guard let component = input.components.first, component.coordinates.count > 1 else {
            return nil
        }
        
        return Line(coordinates: component.coordinates)
    }
}

struct WKTPolygonSerialization: WKTSerizalization {
    typealias Output = Polygon
    
    func geometry(from input: WKTType) -> Polygon? {
        if input.components.count < 1 {
            return nil
        }
        
        guard let body = input.components.first, body.coordinates.count > 1 else {
            return nil
        }
        
        let interiorPolygons = Array(input.components[1..<input.components.endIndex])
        return Polygon(coordinates: body.coordinates,
                       interiorPolygons: interiorPolygons.map { Polygon(coordinates: $0.coordinates, interiorPolygons: nil) })
    }
}
