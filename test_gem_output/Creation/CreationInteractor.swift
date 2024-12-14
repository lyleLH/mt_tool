//
//  CreationInteractor.swift
//  Creation
//
//  Created by Tom.Liu on 2024-12-13.
//

import Foundation

// MARK: - Interactor Protocol
protocol CreationInteractorProtocol: AnyObject {
    var presenter: CreationInteractorToPresenterProtocol? { get set }
    
    func fetchData(request: CreationRequest)
    func performAction()
}

// MARK: - Presenter to Interactor Protocol
protocol CreationInteractorToPresenterProtocol: AnyObject {
    func didFetchData(response: CreationResponse)
    func didFailToFetchData(error: Error)
    func didCompleteAction()
}

// MARK: - Interactor Implementation
final class CreationInteractor {
    weak var presenter: CreationInteractorToPresenterProtocol?
    
    // MARK: - Private Properties
    private let service: NetworkServiceProtocol // Replace with your actual service
    
    // MARK: - Initialization
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
}

// MARK: - CreationInteractorProtocol
extension CreationInteractor: CreationInteractorProtocol {
    func fetchData(request: CreationRequest) {
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
