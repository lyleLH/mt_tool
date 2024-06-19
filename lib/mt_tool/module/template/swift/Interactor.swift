//
//  <%= @prefixed_module %>Interactor.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

import Foundation

protocol <%= @prefixed_module %>InteractorProtocol {
}

class <%= @prefixed_module %>Interactor: <%= @prefixed_module %>InteractorProtocol {
    weak var presenter: <%= @prefixed_module %>PresenterProtocol?
}
