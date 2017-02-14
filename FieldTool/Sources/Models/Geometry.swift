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
