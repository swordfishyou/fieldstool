//
//  MKOverlayPathRenderer+Renderer.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

extension MKOverlayPathRenderer: Renderer {
    var overlayRenderer: MKOverlayRenderer {
        return self
    }
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let point = MKMapPointForCoordinate(coordinate)
        return self.path.contains(self.point(for: point))
    }
    
    func apply(_ style: GeometryStyle) {
        self.lineWidth = style.lineWidth
        self.strokeColor = style.strokeColor
        self.fillColor = style.fillColor
    }
}
