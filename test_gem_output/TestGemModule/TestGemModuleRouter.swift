//
//  TestGemModuleRouter.swift
//  TestGemModule
//
//  Created by Test Author on 2024-12-13.
//

import UIKit

// MARK: - Router Protocol
protocol TestGemModuleRouterProtocol: AnyObject {
    var viewController: UIViewController { get }
    
    static func createModule() -> TestGemModuleRouter
    @MainActor func navigateToNextScreen()
    @MainActor func navigateBack()
}

// MARK: - Router Implementation
final class TestGemModuleRouter {
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

// MARK: - TestGemModuleRouterProtocol
extension TestGemModuleRouter: TestGemModuleRouterProtocol {
    static func createModule() -> TestGemModuleRouter {
        let view: TestGemModuleViewController = DIContainer.shared.resolve()
        let router: TestGemModuleRouter = DIContainer.shared.resolve(argument: view)
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
