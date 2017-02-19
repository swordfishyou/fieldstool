//
//  GeometryStyle.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import UIKit

protocol GeometryStyle {
    var strokeColor: UIColor { get }
    var lineWidth: CGFloat { get }
    var fillColor: UIColor { get set }
}

struct HotspotStyle: GeometryStyle {
    var strokeColor: UIColor {
        return UIColor.white
    }
    var lineWidth: CGFloat {
        return 2
    }
    var fillColor: UIColor = UIColor(colorLiteralRed: 200.0/255.0, green: 199.0/255.0, blue: 177.0/255.0, alpha: 1.0)
}

struct FieldStyle: GeometryStyle {
    var strokeColor: UIColor {
        return UIColor.white
    }
    var lineWidth: CGFloat {
        return 2
    }
    var fillColor: UIColor 
}
