//
//  TestGemModulePresenter.swift
//  TestGemModule
//
//  Created by Test Author on 2024-12-13.
//

import Foundation

// MARK: - Presenter Protocol
protocol TestGemModulePresenterProtocol: AnyObject {
    var view: TestGemModuleViewProtocol? { get set }
    var interactor: TestGemModuleInteractorProtocol? { get set }
    var router: TestGemModuleRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didTapActionButton()
}

// MARK: - Presenter Implementation
final class TestGemModulePresenter {
    // MARK: - Properties
    weak var view: TestGemModuleViewProtocol?
    var interactor: TestGemModuleInteractorProtocol?
    var router: TestGemModuleRouterProtocol?
    
    // MARK: - Private Properties
    private var items: [TestGemModuleEntity] = []
}

// MARK: - TestGemModulePresenterProtocol
extension TestGemModulePresenter: TestGemModulePresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        let request = TestGemModuleRequest()
        interactor?.fetchData(request: request)
    }
    
    func viewWillAppear() {
        // TODO: Implement view will appear logic
    }
    
    func didTapActionButton() {
        interactor?.performAction()
    }
}

// MARK: - TestGemModuleInteractorToPresenterProtocol
extension TestGemModulePresenter: TestGemModuleInteractorToPresenterProtocol {
    func didFetchData(response: TestGemModuleResponse) {
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
