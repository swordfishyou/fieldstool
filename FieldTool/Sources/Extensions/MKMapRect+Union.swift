//
//  MKMapRect+Union.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

extension MKMapRect {
    func union(with rect: MKMapRect) -> MKMapRect {
        if MKMapRectIsNull(self) {
            return rect
        }
        
        return MKMapRectUnion(self, rect)
    }
}
