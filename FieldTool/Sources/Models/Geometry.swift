//
//  Geometry.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/12/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import CoreLocation

protocol CoordinatesCollection {
    var coordinates: [CLLocationCoordinate2D] { get set }
}

struct CoordinatesContainer: CoordinatesCollection {
    var coordinates: [CLLocationCoordinate2D]
}

extension CoordinatesContainer {
    public var hashValue: Int {
        let prime = 31
        var result = 1
        
        self.coordinates.forEach {
            result = prime * result + $0.hashValue
        }
        
        return result
    }
    
    public static func == (lhs: CoordinatesContainer, rhs: CoordinatesContainer) -> Bool {
        return lhs.coordinates == rhs.coordinates
    }
}

extension CLLocationCoordinate2D: Hashable {
    public var hashValue: Int {
        return self.latitude.hashValue ^ self.longitude.hashValue
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        let precision = 1e-15
        return (lhs.latitude - rhs.latitude <= precision) && (lhs.longitude - rhs.longitude <= precision)
    }
}
