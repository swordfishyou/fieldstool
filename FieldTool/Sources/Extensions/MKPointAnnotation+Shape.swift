//
//  MKPointAnnotation+Shape.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

extension MKPointAnnotation: Shape {
    var overlay: MKOverlay? {
        return nil
    }
    
    var annotation: MKAnnotation {
        return self
    }
    
    var mapRect: MKMapRect {
        let center = MKMapPointForCoordinate(self.annotation.coordinate)
        return MKMapRectMake(center.x, center.y, 0, 0)
    }
}
