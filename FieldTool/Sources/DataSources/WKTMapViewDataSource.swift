//
//  WKTMapViewDataSource.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

struct WKTMapViewDataSource<T: GeometryContainer, U: GeometryAnnotation>: GeometryMapViewDataSource where U.Object == T {
    typealias Annotation = U
    typealias Object = T
    var geometries: [Geometry] {
        return self.parsed
    }
    var objects: [T]
    
    private var parsed = [Geometry]()
    
    init(objects: [T]) {
        self.objects = objects
        self.parsed = self.parsedObjects(form: objects)
    }
    
    private func parsedObjects(form input: [T]) -> [Geometry] {
        let parser = WKTParser()
        let serializer = WKTSerializer()
        return input.map { parser.parse($0.geometryString) }.flatMap { $0 }.map { serializer.geometry(from: $0) }
    }
}
