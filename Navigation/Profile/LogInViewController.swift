//
//  LogInViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 09.03.2023.
//

import UIKit

//Создайте новый протокол LoginViewControllerDelegate, для него пропишите один метод check, который будет использовать созданный Checker
protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

class LogInViewController: UIViewController {
    
    //Для класса LoginViewController сделайте свойство loginDelegate с типом LoginViewControllerDelegate
    var loginDelegate: LoginViewControllerDelegate?

    private var userService: UserService? // Добавляем свойство для UserService
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")

        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var loginField: UITextField = { [unowned self] in
        let view = CustomTextField()
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.placeholder = "Email or phone"
        view.autocapitalizationType = .none
        view.returnKeyType = .done
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private lazy var passwordField: UITextField = {
        let view = CustomTextField()
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.placeholder = "Password"
        view.autocapitalizationType = .none
//        view.isSecureTextEntry = true
        view.returnKeyType = .done
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var loginView: UIStackView = {
        let view = UIStackView()
        view.layer.backgroundColor = UIColor.systemGray6.cgColor
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.3
        view.layer.cornerRadius = 10
        view.tintColor = UIColor(named: "ColorSet")

        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 0.0

        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator.translatesAutoresizingMaskIntoConstraints = false

        view.addArrangedSubview(loginField)
        view.addArrangedSubview(separator)
        view.addArrangedSubview(passwordField)

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var loginButton: CustomButton = {
        let view = CustomButton(custom: true, initAction: .logIn, color: UIColor(named: "ColorSet"))
        view.backgroundColor = .white
        view.layer.backgroundColor = view.color?.cgColor
        view.titleLabel?.textColor = .white
        view.layer.cornerRadius = 10

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addSubviews()
        setConstraints()
        addContentSubviews()
        
        #if DEBUG
        userService = TestUserService()
        #else
        // Инициализируем userService с помощью CurrentUserService
        let currentUser = User(
            login: "aaa",
            fullName: "Playful Cat",
            avatar: UIImage(named: "cat")!,
            status: "Do you think I'm playing games with you?")
        userService = CurrentUserService(currentUser: currentUser)
        #endif
  
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    

    private func setup() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        loginButton.addTarget(self, action: #selector(pushToProfile(_:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    
    private func setKeyboardObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func addContentSubviews() {
        contentView.addSubview(logoImage)
        contentView.addSubview(loginView)
        contentView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            loginView.heightAnchor.constraint(equalToConstant: 100),
            loginView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            loginView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    
    @objc private func willShowKeyboard(_ notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        
        if contentView.frame.height > keyboardHeight {
            scrollView.contentInset.bottom = keyboardHeight
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc func pushToProfile(_ button: UIButton) {
        //Реализуйте в LoginViewController проверку логина и пароля, введённого пользователем с помощью loginDelegate
        guard let login = loginField.text, let password = passwordField.text else { return }

        let isValid = loginDelegate?.check(login: login, password: password) ?? false

        if isValid {
            // Правильный ввод логина и пароля
            // Получаем информацию о пользователе, введенном в loginField
            let user = userService?.getUser(byLogin: login) // Используем userService

            // Создаем ProfileViewController и передаем ему информацию о пользователе
            let profileVC = ProfileViewController()
            profileVC.user = user
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            // Неверный ввод логина и пароля
            let alert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    //Создание сообщения об ошибке
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
