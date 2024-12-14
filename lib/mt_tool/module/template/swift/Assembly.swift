//
//  <%= @prefixed_module %>Assembly.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//

import Swinject

final class <%= @prefixed_module %>Assembly: Assembly {
    
    func assemble(container: Container) {
        
        // Register Interactor
        container.register(<%= @prefixed_module %>InteractorProtocol.self) { _ in
            return <%= @prefixed_module %>Interactor()
        }
        
        // Register Presenter
        container.register(<%= @prefixed_module %>PresenterProtocol.self) { (resolver, view: <%= @prefixed_module %>ViewController) in
            
            guard let interactor = resolver.resolve(<%= @prefixed_module %>InteractorProtocol.self) else {
                fatalError("<%= @prefixed_module %>InteractorProtocol dependency could not be resolved")
            }
            guard let router = resolver.resolve(<%= @prefixed_module %>Router.self, argument: view) else {
                fatalError("<%= @prefixed_module %>Router dependency could not be resolved")
            }
            
            let presenter = <%= @prefixed_module %>Presenter()
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            
            return presenter
        }
        
        // Register View Controller
        container.register(<%= @prefixed_module %>ViewController.self) { (resolver) in
            let view = <%= @prefixed_module %>ViewController()
            guard let presenter = resolver.resolve(<%= @prefixed_module %>PresenterProtocol.self, argument: view) else {
                fatalError("<%= @prefixed_module %>Presenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
        
        // Register Router
        container.register(<%= @prefixed_module %>Router.self) { (_, view: <%= @prefixed_module %>ViewController) in
            return <%= @prefixed_module %>Router(viewController: view)
        }
    }
}
