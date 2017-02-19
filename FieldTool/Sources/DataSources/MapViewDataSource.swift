//
//  MapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol MapViewDataSource {
    var overlays: [MKOverlay] { get }
    var annotations: [MKAnnotation] { get }
    var boundingRect: MKMapRect { get }
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer?
}
