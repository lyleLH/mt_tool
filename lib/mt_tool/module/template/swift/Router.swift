//
//  <%= @prefixed_module %>Router.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//

import UIKit

// MARK: - Router Protocol
protocol <%= @prefixed_module %>RouterProtocol: AnyObject {
    var viewController: UIViewController { get }
    
    static func createModule() -> <%= @prefixed_module %>Router
    @MainActor func navigateToNextScreen()
    @MainActor func navigateBack()
}

// MARK: - Router Implementation
final class <%= @prefixed_module %>Router {
    // MARK: - Properties
    internal var viewController: UIViewController
    
    // MARK: - Private Properties
    private let navigationController: UINavigationController?
    
    // MARK: - Initialization
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.navigationController = viewController.navigationController
    }
}

// MARK: - <%= @prefixed_module %>RouterProtocol
extension <%= @prefixed_module %>Router: <%= @prefixed_module %>RouterProtocol {
    static func createModule() -> <%= @prefixed_module %>Router {
        let view: <%= @prefixed_module %>ViewController = DIContainer.shared.resolve()
        let router: <%= @prefixed_module %>Router = DIContainer.shared.resolve(argument: view)
        return router
    }
    
    @MainActor
    func navigateToNextScreen() {
        // TODO: Implement navigation logic
        // Example:
        // DispatchQueue.main.async { [weak self] in
        //     let nextModule = NextModuleRouter.createModule()
        //     self?.navigationController?.pushViewController(nextModule, animated: true)
        // }
    }
    
    @MainActor
    func navigateBack() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
