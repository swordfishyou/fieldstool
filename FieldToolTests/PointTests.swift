//
//  PointTests.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/16/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import XCTest
import CoreLocation

class PointTests: XCTestCase {
    func testPointCenterEqualsPointCoordinates() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        let expectedResult = CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)
        // Act
        let actualResutl = point.center
        // Assert
        XCTAssertEqual(expectedResult, actualResutl)
    }
    
    func testPointDoesNotHaveRenderer() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        // Assert
        XCTAssertNil(point.renderer)
    }
    
    func testPointDoesNotContainOwnCoordinate() {
        // Arrange
        let coordinateToContain = CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        // Assert
        XCTAssertFalse(point.contains(coordinate: coordinateToContain))
    }
    
    func testPointDoesNotContainAnyCoordinate() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        let coordinatesToContain = [CLLocationCoordinate2D(latitude: 13.523, longitude: 42.61411),
                                    CLLocationCoordinate2D(latitude: -52.8434, longitude: 0.5561),
                                    CLLocationCoordinate2D(latitude: 153.6331, longitude: -75.1341),
                                    CLLocationCoordinate2D(latitude: -3.2351, longitude: -11.0041)]
        let expectedResults = [false, false, false, false]
        // Act
        let actualResults = coordinatesToContain.map { point.contains(coordinate: $0) }
        // Assert
        XCTAssertEqual(actualResults, expectedResults)
    }
    
    func testPointDoesNotContainItself() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        let pointToContain = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        // Assert
        XCTAssertFalse(point.contains(geometry: pointToContain))
    }
    
    func testPointDoesNotContainAnyPoint() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        let pointsToContain = [CLLocationCoordinate2D(latitude: 13.523, longitude: 42.61411),
                               CLLocationCoordinate2D(latitude: -52.8434, longitude: 0.5561),
                               CLLocationCoordinate2D(latitude: 153.6331, longitude: -75.1341),
                               CLLocationCoordinate2D(latitude: -3.2351, longitude: -11.0041)]
                             .map { Point(coordinates: [$0]) }
        let expectedResults = [false, false, false, false]
        // Act
        let actualResults = pointsToContain.map { point.contains(geometry: $0) }
        // Assert
        XCTAssertEqual(actualResults, expectedResults)
    }
    
    func testPointDoesNotContainAnyLine() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261)])
        let linesToContain = [Line(coordinates: [CLLocationCoordinate2D(latitude: 20.4123, longitude: 8.6261),
                                                 CLLocationCoordinate2D(latitude: 12.6242, longitude: 18.5141)]),
                              Line(coordinates: [CLLocationCoordinate2D(latitude: -12.8323, longitude: 51.8201),
                                                 CLLocationCoordinate2D(latitude: -12.7411, longitude: 50.8999)]),
                              Line(coordinates: [CLLocationCoordinate2D(latitude: -141.3313, longitude: -63.8420),
                                                 CLLocationCoordinate2D(latitude: -142.0000, longitude: -62.9999)]),
                              Line(coordinates: [CLLocationCoordinate2D(latitude: 0.3101, longitude: 0.0044),
                                                 CLLocationCoordinate2D(latitude: -0.0318, longitude: -0.1004)])]
        let expectedResults = [false, false, false, false]
        // Act
        let actualResults = linesToContain.map { point.contains(geometry: $0) }
        // Assert
        XCTAssertEqual(actualResults, expectedResults)
    }
    
    func testPointDoesNotContainAnyPolygon() {
        // Arrange
        let point = Point(coordinates: [CLLocationCoordinate2D(latitude: 25.4123, longitude: 18.6261)])
        let polygonsToContain = [Polygon(coordinates: [CLLocationCoordinate2D(latitude: 25.4123, longitude: 18.6261),
                                                       CLLocationCoordinate2D(latitude: 25.5301, longitude: 18.5141),
                                                       CLLocationCoordinate2D(latitude: 25.5321, longitude: 18.6123),
                                                       CLLocationCoordinate2D(latitude: 25.4123, longitude: 18.6261)], interiorPolygons: nil),
                                 Polygon(coordinates: [CLLocationCoordinate2D(latitude: 45.5, longitude: 10.5),
                                                       CLLocationCoordinate2D(latitude: 51.3, longitude: 25.4),
                                                       CLLocationCoordinate2D(latitude: 44.4, longitude: 35.1),
                                                       CLLocationCoordinate2D(latitude: 20.9, longitude: 30.5),
                                                       CLLocationCoordinate2D(latitude: 45.5, longitude: 10.5)],
                                         interiorPolygons: [Polygon(coordinates: [CLLocationCoordinate2D(latitude: 46.1, longitude: 33.2),
                                                                                  CLLocationCoordinate2D(latitude: 45.7, longitude: 33.2),
                                                                                  CLLocationCoordinate2D(latitude: 38.4, longitude: 35.1),
                                                                                  CLLocationCoordinate2D(latitude: 46.1, longitude: 33.2)], interiorPolygons: nil)])]
        let expectedResults = [false, false]
        // Act
        let actualResults = polygonsToContain.map { point.contains(geometry: $0) }
        // Assert
        XCTAssertEqual(actualResults, expectedResults)
    }
}
