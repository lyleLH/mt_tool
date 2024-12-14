//
//  TestGemModuleInteractor.swift
//  TestGemModule
//
//  Created by Test Author on 2024-12-13.
//

import Foundation

// MARK: - Interactor Protocol
protocol TestGemModuleInteractorProtocol: AnyObject {
    var presenter: TestGemModuleInteractorToPresenterProtocol? { get set }
    
    func fetchData(request: TestGemModuleRequest)
    func performAction()
}

// MARK: - Presenter to Interactor Protocol
protocol TestGemModuleInteractorToPresenterProtocol: AnyObject {
    func didFetchData(response: TestGemModuleResponse)
    func didFailToFetchData(error: Error)
    func didCompleteAction()
}

// MARK: - Interactor Implementation
final class TestGemModuleInteractor {
    weak var presenter: TestGemModuleInteractorToPresenterProtocol?
    
    // MARK: - Private Properties
    private let service: NetworkServiceProtocol // Replace with your actual service
    
    // MARK: - Initialization
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
}

// MARK: - TestGemModuleInteractorProtocol
extension TestGemModuleInteractor: TestGemModuleInteractorProtocol {
    func fetchData(request: TestGemModuleRequest) {
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
