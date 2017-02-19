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
    
    func annotations() -> [MKAnnotation]? {
        return self.dataSources.map { $0.annotations() }.flatMap { $0 }.flatMap { $0 }
    }
    
    func overlays() -> [MKOverlay]? {
        return self.dataSources.map { $0.overlays() }.flatMap { $0 }.flatMap { $0 }
    }
    
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer? {
        for dataSourse in self.dataSources {
            if let renderer = dataSourse.renderer(for: overlay) {
                return renderer
            }
        }
        
        return nil
    }
    
    func boundingRect() -> MKMapRect {
        return self.dataSources.reduce(MKMapRectNull) { $0.union($1.boundingRect()) }
    }
}
