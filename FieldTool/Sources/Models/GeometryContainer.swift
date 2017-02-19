//
//  GeometryContainer.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

protocol GeometryContainer {
    var geometryString: String { get set }
    var title: String { get }
    var subtitle: String { get }
    var style: GeometryStyle { get }
}
