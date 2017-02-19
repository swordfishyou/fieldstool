//
//  MapViewController.swift
//  FieldTool
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var dataSource: SegmentedMapViewDataSource!
    var fieldsDataSource: FieldsMapViewDataSource!
    var hotspotsDataSource: HotspotsMapViewDataSource!
    let fieldAnnotationController = FieldAnntotationController()
    let hotspotAnnotationController = HotspotAnntotationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        var dataSources = [MapViewDataSource]()
        let fieldsStorage = FieldsStorage()
        if let fields = fieldsStorage.all() {
            dataSources.append(FieldsMapViewDataSource(fields: fields))
        }
        
        let hotspotsStorage = HotspotsStorage()
        if let hotspots = hotspotsStorage.all() {
            dataSources.append(HotspotsMapViewDataSource(hotspots: hotspots))
        }
        
        let compoundDataSource = CompoundMapViewDataSource(dataSources: dataSources)
        dataSources.insert(compoundDataSource, at: 0)
        self.dataSource = SegmentedMapViewDataSource(dataSources: dataSources)
        self.segmentDidChange(sender: self.segmentedControl)
    }
    
    @IBAction func segmentDidChange(sender: UISegmentedControl) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.removeOverlays(self.mapView.overlays)
        
        self.dataSource.selectedDataSourceIndex = sender.selectedSegmentIndex
        
        if let overlays = self.dataSource.overlays() {
            self.mapView.addOverlays(overlays)
        }
        
        if let annotations = self.dataSource.annotations() {
            self.mapView.addAnnotations(annotations)
        }
        
        self.mapView.visibleMapRect = self.mapView.mapRectThatFits(self.dataSource.boundingRect(), edgePadding: UIEdgeInsetsMake(15, 15, 15, 15))
    }
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return self.dataSource.renderer(for: overlay)!
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is FieldAnnotation {
            return self.fieldAnnotationController.mapView(mapView, viewFor: annotation as! FieldAnnotation)
        }
        
        return self.hotspotAnnotationController.mapView(mapView, viewFor: annotation as! HotspotAnnotation)
    }
}
