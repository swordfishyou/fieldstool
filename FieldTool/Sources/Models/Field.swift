//
//  Field.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import UIKit

struct Field {
    var identifier: Int
    var name: String
    var number: String
    var area: Double
    var geometryString: String
    var cropColorString: String
}

extension Field: GeometryContainer {
    var title: String {
        return "\(self.number) \(self.name)"
    }
    
    var subtitle: String {
        return "\(self.area)"
    }
    
    var style: GeometryStyle {
        return FieldStyle(fillColor: UIColor(hexString: self.cropColorString)!)
    }
}
