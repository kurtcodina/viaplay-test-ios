//
//  ViaplayPageProtocol.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

protocol ViaplayPageProtocol {
    var type: String { get }
    var pageType: PageType { get }

    var title: String { get }
    var description: String { get }
    
    var links: ViaplayLinks { get }
}
