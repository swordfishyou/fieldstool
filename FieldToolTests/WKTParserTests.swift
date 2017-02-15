//
//  WKTParserTests.swift
//  FieldTool
//

import XCTest
import CoreLocation

class WKTParserTests: XCTestCase {
    var sut: WKTParser!
    
    override func setUp() {
        super.setUp()
        self.sut = WKTParser()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testWKTParserCorrectlyParsesValidWKTPoint() {
        // Arrange
        let input = "POINT (10.5252 30.4401)"
        let expectedResult = WKTType(name: "POINT",
                                     components: [CoordinatesContainer(coordinates: [CLLocationCoordinate2D(latitude: 30.4401, longitude: 10.5252)])])
        // Act
        let actualResult = self.sut.parse(input)
        // Assert
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testWKTParserCorrectlyParsesValidWKTLine() {
        // Arrange
        let input = "LINESTRING (10.5252 30.4401, 30.1661 10.0027, 40.2201 40.1106)"
        let expectedResult = WKTType(name: "LINESTRING",
                                     components: [CoordinatesContainer(coordinates: [CLLocationCoordinate2D(latitude: 30.4401, longitude: 10.5252),
                                                                                     CLLocationCoordinate2D(latitude: 10.0027, longitude: 30.1661),
                                                                                     CLLocationCoordinate2D(latitude: 40.1106, longitude: 40.2201)])])
        // Act
        let actualResult = self.sut.parse(input)
        // Assert
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testWKTParserCorrectlyParsesValidWKTPolygonWithoutInteriorPolygons() {
        // Arrange
        let input = "POLYGON ((30.1661 10.0027, 40.2201 40.1106, 20.2451 40.2510, 10.7136 20.2715, 30.1661 10.0027))"
        let expectedResult = WKTType(name: "POLYGON",
                                     components: [CoordinatesContainer(coordinates: [CLLocationCoordinate2D(latitude: 10.0027, longitude: 30.1661),
                                                                                     CLLocationCoordinate2D(latitude: 40.1106, longitude: 40.2201),
                                                                                     CLLocationCoordinate2D(latitude: 40.2510, longitude: 20.2451),
                                                                                     CLLocationCoordinate2D(latitude: 20.2715, longitude: 10.7136),
                                                                                     CLLocationCoordinate2D(latitude: 10.0027, longitude: 30.1661)])])
        // Act
        let actualResult = self.sut.parse(input)
        // Assert
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testWKTParserCorrectlyParsesValidWKTPolygonWithInteriorPolygons() {
        // Arrange
        let input = "POLYGON ((35.6247 10.1361, 45.9472 45.0007, 15.3567 40.2514, 10.7136 20.2715, 35.6247 10.1361), (20.8325 30.3524, 35.2246 35.1624, 30.2452 20.5858, 20.8325 30.3524))"
        let expectedResult = WKTType(name: "POLYGON",
                                     components: [CoordinatesContainer(coordinates: [CLLocationCoordinate2D(latitude: 10.1361, longitude: 35.6247),
                                                                                     CLLocationCoordinate2D(latitude: 45.0007, longitude: 45.9472),
                                                                                     CLLocationCoordinate2D(latitude: 40.2514, longitude: 15.3567),
                                                                                     CLLocationCoordinate2D(latitude: 20.2715, longitude: 10.7136),
                                                                                     CLLocationCoordinate2D(latitude: 10.1361, longitude: 35.6247)]),
                                                  CoordinatesContainer(coordinates: [CLLocationCoordinate2D(latitude: 30.3524, longitude: 20.8325),
                                                                                     CLLocationCoordinate2D(latitude: 35.1624, longitude: 35.2246),
                                                                                     CLLocationCoordinate2D(latitude: 20.5858, longitude: 30.2452),
                                                                                     CLLocationCoordinate2D(latitude: 30.3524, longitude: 20.8325)])])
        // Act
        let actualResult = self.sut.parse(input)
        // Assert
        XCTAssertEqual(actualResult, expectedResult)
    }
}
