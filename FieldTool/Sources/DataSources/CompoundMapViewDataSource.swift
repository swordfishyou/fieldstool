//
//  CompoundMapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct CompoundMapViewDataSource: MapViewDataSource {
    var dataSources: [MapViewDataSource]
    
    var annotations: [MKAnnotation] {
        return self.dataSources.map { $0.annotations }.flatMap { $0 }
    }
    
    var overlays: [MKOverlay] {
        return self.dataSources.map { $0.overlays }.flatMap { $0 }
    }
    
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer? {
        for dataSourse in self.dataSources {
            if let renderer = dataSourse.renderer(for: overlay) {
                return renderer
            }
        }
        
        return nil
    }
    
    var boundingRect: MKMapRect {
        return self.dataSources.reduce(MKMapRectNull) { $0.union(with: $1.boundingRect) }
    }
}
