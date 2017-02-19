//
//  AnntotationController.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/19/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

protocol AnntotationController {
    associatedtype Annotation: MKAnnotation
    associatedtype View: MKAnnotationView
    
    var reuseIdentifier: String { get }
    func mapView(_ mapView: MKMapView, viewFor annotation: Annotation) -> View?
    func configure(_ view: View, with annotation: Annotation)
}

extension AnntotationController {
    func mapView(_ mapView: MKMapView, viewFor annotation: Annotation) -> View? {
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: self.reuseIdentifier) as? View {
            self.configure(view, with: annotation)
            return view
        }
        
        let view = View(annotation: annotation, reuseIdentifier: self.reuseIdentifier)
        self.configure(view, with: annotation)
        return view
    }
}
