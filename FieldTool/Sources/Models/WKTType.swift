//
//  WKTType.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/12/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

struct WKTType {
    var name: String
    var components: [CoordinatesCollection]
}

extension WKTType: Hashable {
    public var hashValue: Int {
        let prime = 31
        var result = 1
        
        self.components.map { $0.coordinates }.flatMap { $0 }.forEach {
            result = prime + $0.hashValue
        }
        
        return result
    }
    
    public static func == (lhs: WKTType, rhs: WKTType) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
