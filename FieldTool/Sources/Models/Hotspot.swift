//
//  Hotspot.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

struct Hotspot {
    var identifier: Int
    var type: Int
    var geometryString: String
    
    var annotationImageName: String {
        return "map-annotation-\(self.type)"
    }
}

extension Hotspot: GeometryContainer {
    var title: String {
        return "Hotspot"
    }
    
    var subtitle: String {
        return ""
    }
    
    var style: GeometryStyle {
        return HotspotStyle()
    }
}
