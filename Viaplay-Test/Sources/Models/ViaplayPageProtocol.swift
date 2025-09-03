//
//  ViaplayPageProtocol.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

// This protocol is not currently used, but will be used in the future to match the JSON structure of ViaplayPage.

protocol ViaplayPageProtocol {
    var type: String { get }
    var pageType: PageType { get }

    var title: String { get }
    var description: String { get }
    
    var links: ViaplayLinks { get }
}
