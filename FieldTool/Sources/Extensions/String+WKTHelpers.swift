//
//  String+WKTHelpers.swift
//  FieldTool
//

import Foundation

extension String {
    func geometryName() -> String {
        let charactersToTrim = CharacterSet.uppercaseLetters.inverted
        return self.trimmingCharacters(in: charactersToTrim)
    }
    
    func trimmingGeometryName() -> String {
        let uppercaseLetters = CharacterSet.uppercaseLetters
        let charactersToTrim = uppercaseLetters.union(CharacterSet.whitespacesAndNewlines)
        return self.trimmingCharacters(in: charactersToTrim)
    }
    
    func trimmingParentheses() -> String {
        let charactersToTrim = CharacterSet(charactersIn: "()")
        return self.trimmingCharacters(in: charactersToTrim)
    }
    
    func replacingGeometriesSeparator(with delimiter: String) -> String {
        return self.replacingOccurrences(of: "\\)(\\s*,\\s*)\\(",
                                         with: delimiter,
                                         options: .regularExpression,
                                         range: self.range(of: self))
    }
    
    func replacingCoordinatesSeparator(with delimiter: String) -> String {
        return self.replacingOccurrences(of: "(\\s*,\\s*)",
                                         with: delimiter,
                                         options: .regularExpression,
                                         range: self.range(of: self))
    }
    
    func coordinates(separatedBy delimiter: String) -> String {
        let trimmedParanetesis = self.trimmingParentheses()
        return trimmedParanetesis.replacingCoordinatesSeparator(with: delimiter)
    }
    
    func geometryComponents(separatedBy delimiter: String) -> [String] {
        let trimmed = self.trimmingGeometryName()
        let rawComponentsString = trimmed.replacingGeometriesSeparator(with: delimiter)
        let rawComponents = rawComponentsString.components(separatedBy: delimiter)
        
        var components = [String]()
        for raw in rawComponents {
            if !raw.isEmpty {
                components.append(raw.coordinates(separatedBy: delimiter))
            }
        }
        
        return components
    }
}
