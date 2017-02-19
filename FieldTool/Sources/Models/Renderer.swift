//
//  Renderer.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol Renderer {
    var overlayRenderer: MKOverlayRenderer { get }
    func contains(coordinate: CLLocationCoordinate2D) -> Bool
    func apply(_ style: GeometryStyle)
}
