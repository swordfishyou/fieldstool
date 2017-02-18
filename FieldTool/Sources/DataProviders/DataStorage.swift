//
//  DataStorage.swift
//  FieldTool
//
//  Created by Anatoly Tukhtarov on 2/18/17.
//  Copyright © 2017 Anatoly Tukhtarov. All rights reserved.
//

import Foundation

protocol DataStorage {
    associatedtype Object
    func all() -> [Object]?
}

protocol JSONDataStorage: DataStorage {
    associatedtype Serializer: JSONSerializer
    var url: URL { get }
    var serializer: Serializer { get }
}

extension JSONDataStorage where Self.Object == Self.Serializer.Output {
    private func jsonData() -> Data? {
        return try? Data(contentsOf: self.url)
    }
    
    private func representations() -> [[String : Any]]? {
        guard let data = self.jsonData() else {
            return nil
        }
        
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json as? [[String : Any]]
    }
    
    func all() -> [Object]? {
        guard let representations = self.representations() else {
            return nil
        }
        
        return representations.map { self.serializer.object(from: $0) }
    }
}
