//
//  String+RemovingURITemplates.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

extension String {
    func removingURITemplates() -> String {
        let uriTemplatePattern = "\\{[^}]+\\}"
        return  self.replacingOccurrences(of: uriTemplatePattern, with: "", options: .regularExpression)
    }
}
