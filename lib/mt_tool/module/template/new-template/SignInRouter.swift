//
//  SignInRouter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import UIKit

protocol SignInRouterProtocol {
    var viewController: UIViewController { get }
    func routeToMain()
}

class SignInRouter: SignInRouterProtocol {
    
    internal var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createModule() -> SignInRouter {
        let view: SignInViewController =  DIContainer.shared.resolve()
        let router: SignInRouter = DIContainer.shared.resolve(argument: view)
        return router
    }
    
    @MainActor
    func routeToMain() {
        DispatchQueue.main.async { [weak self] in
            let main = MainRouter.createModule()
            self?.viewController.navigationController?.pushViewController(main, animated: true)
        }
    }
 
}
