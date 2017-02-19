//
//  WKTSerialization.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/16/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol WKTSerizalization {
    func geometry(from input: WKTType) -> Geometry
}

struct WKTPointSerialization: WKTSerizalization {
    func geometry(from input: WKTType) -> Geometry {
        return Point(coordinates: input.components.first!.coordinates)
    }
}

struct WKTLineSerialization: WKTSerizalization {
    func geometry(from input: WKTType) -> Geometry {
        return Line(coordinates: input.components.first!.coordinates)
    }
}

struct WKTPolygonSerialization: WKTSerizalization {
    func geometry(from input: WKTType) -> Geometry {
        let interiorPolygons = Array(input.components[1..<input.components.endIndex])
        return Polygon(coordinates: input.components.first!.coordinates,
                       interiorPolygons: interiorPolygons.map { Polygon(coordinates: $0.coordinates, interiorPolygons: nil) })
    }
}

struct WKTSerializer: WKTSerizalization {
    func geometry(from input: WKTType) -> Geometry {
        return self.serialization(for: input).geometry(from: input)
    }
    
    private func serialization(for input: WKTType) -> WKTSerizalization {
        switch input.name {
        case "POINT":
            return WKTPointSerialization()
        case "LINESTRING":
            return WKTLineSerialization()
        default:
            return WKTPolygonSerialization()
        }
    }
}
