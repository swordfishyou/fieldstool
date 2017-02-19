//
//  WKTType.swift
//  FieldTool
//

import Foundation

struct WKTType {
    var name: String
    var components: [CoordinatesCollection]
}

extension WKTType: Hashable {
    public var hashValue: Int {
        var result = 31
        
        self.components.map { $0.coordinates }.flatMap { $0 }.forEach {
            result = result + $0.hashValue
        }
        
        return result
    }
    
    public static func == (lhs: WKTType, rhs: WKTType) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
