//
//  <%= @prefixed_module %>Presenter.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//

import Foundation

// MARK: - Presenter Protocol
protocol <%= @prefixed_module %>PresenterProtocol: AnyObject {
    var view: <%= @prefixed_module %>ViewProtocol? { get set }
    var interactor: <%= @prefixed_module %>InteractorProtocol? { get set }
    var router: <%= @prefixed_module %>RouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didTapActionButton()
}

// MARK: - Presenter Implementation
final class <%= @prefixed_module %>Presenter {
    // MARK: - Properties
    weak var view: <%= @prefixed_module %>ViewProtocol?
    var interactor: <%= @prefixed_module %>InteractorProtocol?
    var router: <%= @prefixed_module %>RouterProtocol?
    
    // MARK: - Private Properties
    private var items: [<%= @prefixed_module %>Entity] = []
}

// MARK: - <%= @prefixed_module %>PresenterProtocol
extension <%= @prefixed_module %>Presenter: <%= @prefixed_module %>PresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        let request = <%= @prefixed_module %>Request()
        interactor?.fetchData(request: request)
    }
    
    func viewWillAppear() {
        // TODO: Implement view will appear logic
    }
    
    func didTapActionButton() {
        interactor?.performAction()
    }
}

// MARK: - <%= @prefixed_module %>InteractorToPresenterProtocol
extension <%= @prefixed_module %>Presenter: <%= @prefixed_module %>InteractorToPresenterProtocol {
    func didFetchData(response: <%= @prefixed_module %>Response) {
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
