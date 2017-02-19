//
//  MapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol MapViewDataSource {
    func overlays() -> [MKOverlay]?
    func annotations() -> [MKAnnotation]?
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer?
    func boundingRect() -> MKMapRect
}

extension MKMapRect {
    func union(_ rect: MKMapRect) -> MKMapRect {
        if MKMapRectIsNull(self) {
            return rect
        }
        
        return MKMapRectUnion(self, rect)
    }
}

extension MKOverlayPathRenderer {
    func apply(_ styles: GeometryStyle) {
        self.lineWidth = styles.lineWidth
        self.strokeColor = styles.strokeColor
        self.fillColor = styles.fillColor
    }
}
