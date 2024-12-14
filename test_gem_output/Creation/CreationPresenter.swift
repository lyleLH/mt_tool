//
//  CreationPresenter.swift
//  Creation
//
//  Created by Tom.Liu on 2024-12-13.
//

import Foundation

// MARK: - Presenter Protocol
protocol CreationPresenterProtocol: AnyObject {
    var view: CreationViewProtocol? { get set }
    var interactor: CreationInteractorProtocol? { get set }
    var router: CreationRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didTapActionButton()
}

// MARK: - Presenter Implementation
final class CreationPresenter {
    // MARK: - Properties
    weak var view: CreationViewProtocol?
    var interactor: CreationInteractorProtocol?
    var router: CreationRouterProtocol?
    
    // MARK: - Private Properties
    private var items: [CreationEntity] = []
}

// MARK: - CreationPresenterProtocol
extension CreationPresenter: CreationPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        let request = CreationRequest()
        interactor?.fetchData(request: request)
    }
    
    func viewWillAppear() {
        // TODO: Implement view will appear logic
    }
    
    func didTapActionButton() {
        interactor?.performAction()
    }
}

// MARK: - CreationInteractorToPresenterProtocol
extension CreationPresenter: CreationInteractorToPresenterProtocol {
    func didFetchData(response: CreationResponse) {
        // TODO: Process response and update view
        view?.hideLoading()
        // Example:
        // items = response.items
        // view?.updateUI(with: items)
    }
    
    func didFailToFetchData(error: Error) {
        view?.hideLoading()
        view?.showError(message: error.localizedDescription)
    }
    
    func didCompleteAction() {
        // TODO: Handle action completion
        router?.navigateToNextScreen()
    }
}
