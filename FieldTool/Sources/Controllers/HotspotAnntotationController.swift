//
//  HotspotAnntotationController.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct HotspotAnntotationController: AnntotationController {
    typealias Annotation = HotspotAnnotation
    typealias View = MKAnnotationView
    
    var reuseIdentifier: String {
        return "hotspotReuseIdentifier"
    }
    
    func configurate(_ view: MKAnnotationView, with annotation: HotspotAnnotation) {
        view.image = UIImage(named: annotation.object.annotationImageName)
        view.centerOffset = CGPoint(x: 0, y: -view.bounds.midY)
    }
}
