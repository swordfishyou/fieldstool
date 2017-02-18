//
//  FieldsStorage.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

struct FieldsStorage: JSONDataStorage {
    typealias Object = Field
    typealias Serializer = FieldJSONSerializer
    
    var url: URL {
        return Bundle.main.url(forResource: "fields", withExtension: "json")!
    }
    
    var serializer: FieldJSONSerializer {
        return FieldJSONSerializer()
    }
}
