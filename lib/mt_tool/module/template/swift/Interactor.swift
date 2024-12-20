//
//  <%= @prefixed_module %>Interactor.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//

import Foundation

// MARK: - Interactor Protocol
protocol <%= @prefixed_module %>InteractorProtocol: AnyObject {
    var presenter: <%= @prefixed_module %>InteractorToPresenterProtocol? { get set }
    
    func fetchData(request: <%= @prefixed_module %>Request)
    func performAction()
}

// MARK: - Presenter to Interactor Protocol
protocol <%= @prefixed_module %>InteractorToPresenterProtocol: AnyObject {
    func didFetchData(response: <%= @prefixed_module %>Response)
    func didFailToFetchData(error: Error)
    func didCompleteAction()
}

// MARK: - Interactor Implementation
final class <%= @prefixed_module %>Interactor {
    weak var presenter: <%= @prefixed_module %>InteractorToPresenterProtocol?
    
    // MARK: - Private Properties
    private let service: NetworkServiceProtocol // Replace with your actual service
    
    // MARK: - Initialization
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
}

// MARK: - <%= @prefixed_module %>InteractorProtocol
extension <%= @prefixed_module %>Interactor: <%= @prefixed_module %>InteractorProtocol {
    func fetchData(request: <%= @prefixed_module %>Request) {
        // TODO: Implement data fetching logic
        // Example:
        // service.fetch(request) { [weak self] result in
        //     switch result {
        //     case .success(let response):
        //         self?.presenter?.didFetchData(response: response)
        //     case .failure(let error):
        //         self?.presenter?.didFailToFetchData(error: error)
        //     }
        // }
    }
    
    func performAction() {
        // TODO: Implement action logic
        presenter?.didCompleteAction()
    }
}
