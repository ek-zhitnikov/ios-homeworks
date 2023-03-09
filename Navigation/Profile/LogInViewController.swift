//
//  LogInViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 09.03.2023.
//

import UIKit

class LogInViewController: UIViewController {

    private let logoImage: UIImageView = {
        let view = UIImageView()
        let profilePhoto = UIImage(named: "logo")
        view.image = profilePhoto
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logInTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Email of phone"
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16)
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var passTextField: UITextField = {
        let view = UITextField()

        view.placeholder = "Password"
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.textColor = .black
        view.isSecureTextEntry = true
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.axis = .vertical
        stackView.spacing = 0
        
        stackView.addArrangedSubview(self.logInTextField)
        stackView.addArrangedSubview(self.passTextField)
        return stackView
    }()
    
    private let logInButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Log In", for: .normal)
        view.tintColor = .white
        let bluePixel = UIImage(named: "blue_pixel")
        view.setBackgroundImage(bluePixel, for: .normal)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true

        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
  
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        view.addSubview(stackView)
        view.addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInTextField.heightAnchor.constraint(equalToConstant: 50),
            passTextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 120),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)

            
        ])
    }

}
