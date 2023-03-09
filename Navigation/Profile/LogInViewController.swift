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
        view.font = UIFont.systemFont(ofSize: 16)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.textColor = .black
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.contentVerticalAlignment = .center
        view.contentHorizontalAlignment = .leading
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
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.contentVerticalAlignment = .center
        view.contentHorizontalAlignment = .leading
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubViews()
        setupConstraints()

  
    }
    func setupView () {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    func addSubViews () {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)

        contentView.addSubview(logoImage)
        contentView.addSubview(stackView)
        contentView.addSubview(logInButton)
    }
    
    func setupConstraints () {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),


            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            logInTextField.heightAnchor.constraint(equalToConstant: 50),
            passTextField.heightAnchor.constraint(equalToConstant: 50),

            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 120),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
            
    }
    

}
