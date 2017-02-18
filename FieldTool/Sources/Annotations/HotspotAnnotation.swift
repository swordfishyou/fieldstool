//
//  HotspotAnnotation.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

class HotspotAnnotation: MKPointAnnotation {
    var hotspot: Hotspot
    
    init(hotspot: Hotspot) {
        self.hotspot = hotspot
        super.init()
        self.title = "Hotspot"
    }
}
