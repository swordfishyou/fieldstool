//
//  SegmentedMapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct SegmentedMapViewDataSource: MapViewDataSource {
    let dataSources: [MapViewDataSource]
    var selectedDataSourceIndex: Int = 0 {
        willSet(new) {
            if new < self.dataSources.count && new >= 0 {
                self.selectedDataSource = self.dataSources[new]
            }
        }
    }
    
    private var selectedDataSource: MapViewDataSource! = nil
    
    init(dataSources: [MapViewDataSource]) {
        self.dataSources = dataSources
        self.selectedDataSource = self.dataSources[0]
    }
    
    var annotations: [MKAnnotation] {
        return self.selectedDataSource.annotations
    }
    
    var overlays: [MKOverlay] {
        return self.selectedDataSource.overlays
    }
    
    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer? {
        return self.selectedDataSource.renderer(for: overlay)
    }
    
    var boundingRect: MKMapRect {
        return self.selectedDataSource.boundingRect
    }
}
