//
//  URL+RemovingURITemplates.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import Foundation

extension URL {
    func removingURITemplates() -> URL? {
        let uriTemplatePattern = "%7B.*?%7D"
        let cleaned = self.absoluteString.replacingOccurrences(of: uriTemplatePattern, with: "", options: .regularExpression)
        return URL(string: cleaned)
    }
}
