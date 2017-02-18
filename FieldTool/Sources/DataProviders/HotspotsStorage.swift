//
//  HotspotsStorage.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

struct HotspotsStorage: JSONDataStorage {
    typealias Object = Hotspot
    typealias Serializer = HotspotJSONSerializer
    
    var url: URL {
        return Bundle.main.url(forResource: "hotspots", withExtension: "json")!
    }
    
    var serializer: HotspotJSONSerializer {
        return HotspotJSONSerializer()
    }
}
