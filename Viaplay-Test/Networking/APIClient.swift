//
//  APIClient.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//
import Foundation

protocol APIClient {
    var baseURL: URL { get }
    
    func fetchPage() async throws -> ViaplayPage
}
