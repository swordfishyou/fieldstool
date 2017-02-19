//
//  MKPolyline+Shape.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

extension MKPolyline: Shape {
    var overlay: MKOverlay? {
        return self
    }
    
    var annotation: MKAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.coordinate
        return annotation
    }
    
    var mapRect: MKMapRect {
        return self.boundingMapRect
    }
}
