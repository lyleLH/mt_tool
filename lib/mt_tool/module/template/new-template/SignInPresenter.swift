//
//  SignInPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import Foundation

import UIKit

protocol SignInPresenterProtocol: AnyObject {
    func notifyDidButtonTapped(username: String, password: String)
    func notifyOauth2LoginUserButtonTapped()
}

class SignInPresenter: SignInPresenterProtocol {
    
    private weak var view: SignInViewControllerProtocol?
    private var router: SignInRouterProtocol
    private var interactor: SignInInteractorProtocol
    
    init(router: SignInRouterProtocol, interactor: SignInInteractorProtocol) {
        self.view = router.viewController as? any SignInViewControllerProtocol
        self.router = router
        self.interactor = interactor
    }
    
    func notifyOauth2LoginUserButtonTapped() {
        Task {
            do {
                _ = try await interactor.didLoginByOauth2()
                view?.updateWithSuccess()
                router.routeToMain()
                
            } catch {
                view?.updateWithNotSuccess(error: error as! LocalError)
            }
        }
    }
    
    func notifyDidButtonTapped(username: String, password: String) {
        Task {
            
            do {
                _  = try await interactor.didFetchUser(username: username, password: password)
                view?.updateWithSuccess()
                router.routeToMain()
                
            } catch {
                view?.updateWithNotSuccess(error: error as! LocalError)
            }
        }
    }
    
}
