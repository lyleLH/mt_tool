//
//  CreationRouter.swift
//  Creation
//
//  Created by Tom.Liu on 2024-12-13.
//

import UIKit

// MARK: - Router Protocol
protocol CreationRouterProtocol: AnyObject {
    var viewController: UIViewController { get }
    
    static func createModule() -> CreationRouter
    @MainActor func navigateToNextScreen()
    @MainActor func navigateBack()
}

// MARK: - Router Implementation
final class CreationRouter {
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

// MARK: - CreationRouterProtocol
extension CreationRouter: CreationRouterProtocol {
    static func createModule() -> CreationRouter {
        let view: CreationViewController = DIContainer.shared.resolve()
        let router: CreationRouter = DIContainer.shared.resolve(argument: view)
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
