//
//  FieldAnntotationController.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct FieldAnntotationController: AnntotationController {
    typealias Annotation = FieldAnnotation
    typealias View = FieldAnnotationView
    
    var reuseIdentifier: String {
        return "fieldReuseIdentifier"
    }
    
    func configure(_ view: FieldAnnotationView, with annotation: FieldAnnotation) {
        view.titleLabel.text = annotation.object.number
        view.canShowCallout = true
        view.setNeedsLayout()
        view.centerOffset = CGPoint(x: 0, y: -view.bounds.midY)
    }
}
