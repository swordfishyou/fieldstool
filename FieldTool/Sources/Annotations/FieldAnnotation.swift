//
//  FieldAnnotation.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

class FieldAnnotation: MKPointAnnotation {
    var field: Field
    
    init(field: Field) {
        self.field = field
        super.init()
        self.title = "\(field.number) \(field.name)"
        self.subtitle = "\(field.area)"
    }
}
