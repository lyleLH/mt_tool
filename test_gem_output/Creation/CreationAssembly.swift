//
//  CreationAssembly.swift
//  Creation
//
//  Created by Tom.Liu on 2024-12-13.
//

import Swinject

final class CreationAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Register Interactor
        container.register(CreationInteractorProtocol.self) { _ in
            return CreationInteractor()
        }
        
        // Register Presenter
        container.register(CreationPresenterProtocol.self) { (resolver, view: CreationViewController) in
            
            guard let interactor = resolver.resolve(CreationInteractorProtocol.self) else {
                fatalError("CreationInteractorProtocol dependency could not be resolved")
            }
            guard let router = resolver.resolve(CreationRouter.self, argument: view) else {
                fatalError("CreationRouter dependency could not be resolved")
            }
            
            let presenter = CreationPresenter()
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            
            return presenter
        }
        
        // Register View Controller
        container.register(CreationViewController.self) { (resolver) in
            let view = CreationViewController()
            guard let presenter = resolver.resolve(CreationPresenterProtocol.self, argument: view) else {
                fatalError("CreationPresenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
        
        // Register Router
        container.register(CreationRouter.self) { (_, view: CreationViewController) in
            return CreationRouter(viewController: view)
        }
    }
}
