//
//  Shape.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol Shape {
    var overlay: MKOverlay? { get }
    var annotation: MKAnnotation { get }
    var mapRect: MKMapRect { get }
}
