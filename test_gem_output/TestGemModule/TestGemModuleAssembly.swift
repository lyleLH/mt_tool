//
//  TestGemModuleAssembly.swift
//  TestGemModule
//
//  Created by Test Author on 2024-12-13.
//

import Swinject

final class TestGemModuleAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Register Interactor
        container.register(TestGemModuleInteractorProtocol.self) { _ in
            return TestGemModuleInteractor()
        }
        
        // Register Presenter
        container.register(TestGemModulePresenterProtocol.self) { (resolver, view: TestGemModuleViewController) in
            
            guard let interactor = resolver.resolve(TestGemModuleInteractorProtocol.self) else {
                fatalError("TestGemModuleInteractorProtocol dependency could not be resolved")
            }
            guard let router = resolver.resolve(TestGemModuleRouter.self, argument: view) else {
                fatalError("TestGemModuleRouter dependency could not be resolved")
            }
            
            let presenter = TestGemModulePresenter()
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            
            return presenter
        }
        
        // Register View Controller
        container.register(TestGemModuleViewController.self) { (resolver) in
            let view = TestGemModuleViewController()
            guard let presenter = resolver.resolve(TestGemModulePresenterProtocol.self, argument: view) else {
                fatalError("TestGemModulePresenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
        
        // Register Router
        container.register(TestGemModuleRouter.self) { (_, view: TestGemModuleViewController) in
            return TestGemModuleRouter(viewController: view)
        }
    }
}
