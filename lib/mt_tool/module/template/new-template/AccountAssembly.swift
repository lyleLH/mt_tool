//
//  AccountAssembly.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/20.
//

import Swinject
 
final class AccountAssembly: Assembly {

    func assemble(container: Container) {
        
        container.register(SignInInteractorProtocol.self) { _ in
            return SignInInteractor()
        }
        
        container.register(SignInPresenterProtocol.self) { (resolver, view: SignInViewController) in
            
            guard let interactor = resolver.resolve(SignInInteractorProtocol.self) else {
                fatalError("SignInInteractorProtocol dependency could not be resolved")
            }
            guard let router = resolver.resolve(SignInRouter.self, argument: view) else {
                fatalError("SignInRouter dependency could not be resolved")
            }
            return  SignInPresenter(router: router, interactor: interactor)
        }
        
        container.register(SignInViewController.self) { (resolver) in
            let view = SignInViewController()
            guard let presenter = resolver.resolve(SignInPresenterProtocol.self, argument: view ) else {
                fatalError("SignInPresenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
        
        container.register(SignInRouter.self) { (_, view: SignInViewController) in
             return SignInRouter(viewController: view)
        }
    }

}
