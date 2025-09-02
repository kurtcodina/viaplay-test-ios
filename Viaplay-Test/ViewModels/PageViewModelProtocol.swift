//
//  PageViewModel.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

protocol PageViewModelProtocol {
    var title: String { get }
    var description: String { get }
    
    var isLoading: Bool { get }
    var isStale: Bool { get }
    var errorMessage: String? { get }
    var hasError: Bool { get }
    
    func load() async
}
