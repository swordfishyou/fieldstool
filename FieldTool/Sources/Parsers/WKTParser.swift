//
//  WKTParser.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/12/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import CoreLocation

protocol WKTParserType {
    func parse(_ input: String) -> WKTType?
}

struct WKTParser: WKTParserType {
    private let delimiter = "\t"
    
    func parse(_ input: String) -> WKTType? {
        if input.isEmpty {
            return nil
        }
        
        var coordinates = [CoordinatesCollection]()
        for component in input.geometryComponents(separatedBy: self.delimiter) {
            coordinates.append(self.coordinatesCollection(from: component))
        }
        
        return WKTType(name: input.geometryName(), components: coordinates)
    }
    
    private func coordinatesCollection(from component: String) -> CoordinatesCollection {
        let scanner = Scanner(string: component)
        
        var lat: Double = 0
        var lon: Double = 0
        
        var coordinates = [CLLocationCoordinate2D]()
        
        while !scanner.isAtEnd {
            if scanner.scanDouble(&lon) && scanner.scanDouble(&lat) {
                coordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
            }
            
            scanner.scanString(self.delimiter, into: nil)
        }
        
        return CoordinatesContainer(coordinates: coordinates)
    }
}
