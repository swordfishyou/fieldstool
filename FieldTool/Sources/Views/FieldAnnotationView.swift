//
//  FieldAnnotationView.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import MapKit

class FieldAnnotationView: MKAnnotationView {
    let contentView = UIView()
    let backgroundView = UIImageView(image: #imageLiteral(resourceName: "field-annotation-bubble"))
    let titleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.backgroundView)
        self.contentView.addSubview(self.titleLabel)
        self.configureTitleLabel()
        self.addSubview(self.contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.sizeToFit()
        
        var frame = self.titleLabel.frame
        if frame.width < self.backgroundView.bounds.width {
            var size = frame.size
            size.width = self.backgroundView.bounds.width
            frame.size = size
        } else {
            var imageBounds = self.backgroundView.bounds
            var size = imageBounds.size
            size.width = frame.width + 10
            imageBounds.size = size
            self.backgroundView.bounds = imageBounds
        }
        
        self.titleLabel.frame = frame
        self.titleLabel.center = self.backgroundView.center
        
        self.contentView.bounds = self.backgroundView.bounds
    }
    
    private func configureTitleLabel() {
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 12)
    }
}
