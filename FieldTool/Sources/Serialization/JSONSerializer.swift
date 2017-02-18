//
//  JSONSerializer.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

protocol JSONSerializer {
    associatedtype Output
    func object(from representation: [String : Any]) -> Output
}

struct FieldJSONSerializer: JSONSerializer {
    typealias Output = Field
    
    func object(from representation: [String : Any]) -> Field {
        return Field(identifier: representation["Id"] as! Int,
                     name: representation["Name"] as! String,
                     number: representation["Number"] as! String,
                     area: representation["Area"] as! Double,
                     geometryString: representation["Geometry"] as! String,
                     cropColorString: representation["StandardCropColor"] as! String)
    }
}

struct HotspotJSONSerializer: JSONSerializer {
    typealias Output = Hotspot
    
    func object(from representation: [String : Any]) -> Hotspot {
        return Hotspot(identifier: representation["Id"] as! Int,
                       type: representation["HotspotTypeId"] as! Int,
                       geometryString: representation["Geometry"] as! String)
    }
}
