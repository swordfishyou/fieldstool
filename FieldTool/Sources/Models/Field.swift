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

extension Field {
    var styles: FieldStyle {
        return FieldStyle(fillColor: UIColor(hexString: self.cropColorString)!)
    }
}
