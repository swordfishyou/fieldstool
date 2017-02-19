//
//  GeometryAnnotation.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol GeometryAnnotation: MKAnnotation {
    associatedtype Object: GeometryContainer
    
    var object: Object { get set }
    init(object: Object)
    
    func set(coordinate: CLLocationCoordinate2D)
}
