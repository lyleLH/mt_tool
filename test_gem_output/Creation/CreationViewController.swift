//
//  CreationViewController.swift
//  Creation
//
//  Created by Tom.Liu on 2024-12-13.
//

import UIKit

// MARK: - View Protocol
protocol CreationViewProtocol: AnyObject {
    var presenter: CreationPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func updateUI(with items: [CreationEntity])
}

// MARK: - Entry Point
typealias CreationEntryPoint = CreationViewController

// MARK: - View Controller
final class CreationViewController: UIViewController {
    // MARK: - Properties
    var presenter: CreationPresenterProtocol?
    
    // MARK: - UI Components
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Perform Action", for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Creation"
        
        view.addSubview(contentStackView)
        view.addSubview(loadingIndicator)
        contentStackView.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func actionButtonTapped() {
        presenter?.didTapActionButton()
    }
}

// MARK: - CreationViewProtocol
extension CreationViewController: CreationViewProtocol {
    func showLoading() {
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func updateUI(with items: [CreationEntity]) {
        // TODO: Update UI with items
        // Example:
        // items.forEach { item in
        //     let itemView = ItemView(item: item)
        //     contentStackView.addArrangedSubview(itemView)
        // }
    }
}

