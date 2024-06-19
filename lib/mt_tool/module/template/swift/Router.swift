//
//  <%= @prefixed_module %>Router.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

import UIKit

typealias <%= @prefixed_module %>Entry = <%= @prefixed_module %>ViewProtocol & UIViewController

protocol <%= @prefixed_module %>RouterProtocol {
    var entry: <%= @prefixed_module %>Entry? { get set }
    func routeToSignIn(_ view: <%= @prefixed_module %>ViewProtocol)
    func routeToSignUp(_ view: <%= @prefixed_module %>ViewProtocol)
}

class <%= @prefixed_module %>Router: <%= @prefixed_module %>RouterProtocol {
    
    var entry: <%= @prefixed_module %>Entry?
    
    static func createModule() -> <%= @prefixed_module %>RouterProtocol {
        let view = <%= @prefixed_module %>ViewController()
        let interactor = <%= @prefixed_module %>Interactor()
        let presenter = <%= @prefixed_module %>Presenter()
        let router = <%= @prefixed_module %>Router()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: <%= @prefixed_module %>ViewProtocol) {
        let signInVC = SignInRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: <%= @prefixed_module %>ViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
