//
//  <%= @prefixed_module %>ViewController.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

import UIKit
protocol <%= @prefixed_module %>ViewProtocol: AnyObject {
    
}

class <%= @prefixed_module %>ViewController: UIViewController, <%= @prefixed_module %>ViewProtocol {

    var presenter: <%= @prefixed_module %>PresenterProtocol?

    lazy var button1: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("button 1", for: .normal)
            button.addTarget(self, action: #selector(sampleButton1Tapped), for: .touchUpInside)
            return button
        }()

        lazy var button2: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("button 2", for: .normal)
            button.addTarget(self, action: #selector(sampleButton2Tapped), for: .touchUpInside)
            return button
        }()

        //MARK: - View LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            navigationItem.title = "Sample ViewController"
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

        }

        //MARK: - View Configurations
        private func configureUI() {
            view.backgroundColor = .white
            embedViewController(containerView: view, controller: PeaceCometsViewController(), previous: nil)

            view.addSubview(button1)
            view.addSubview(button2)

            button1.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
            button2.backgroundColor = UIColor.red.withAlphaComponent(0.5)

            setupConstraints()
        }


        func setupConstraints() {
            button1.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
                make.width.equalTo(200)
                make.height.equalTo(50)
            }

            button2.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(button1.snp.bottom).offset(20)
                make.width.equalTo(200)
                make.height.equalTo(50)
            }
        }


        @objc func sampleButton1Tapped() {
            print("sample button 1 tapped")

        }


        @objc func sampleButton2Tapped() {
            print("sample button 2 tapped")

        }
}

