//
//  <%= @prefixed_module %>Presenter.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

import Foundation

protocol <%= @prefixed_module %>PresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class <%= @prefixed_module %>Presenter: <%= @prefixed_module %>PresenterProtocol {
    weak var view: <%= @prefixed_module %>ViewProtocol?
    var router: <%= @prefixed_module %>RouterProtocol?
    var interactor: <%= @prefixed_module %>InteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! <%= @prefixed_module %>ViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! <%= @prefixed_module %>ViewController)
    }
}
