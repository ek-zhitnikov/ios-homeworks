//
//  LogInViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 09.03.2023.
//

import UIKit

//Создайте новый протокол LoginViewControllerDelegate, для него пропишите один метод check, который будет использовать созданный Checker

class LogInViewController: UIViewController {
    weak var coordinator: LoginCoordinator?

    //Для класса LoginViewController сделайте свойство loginDelegate с типом LoginViewControllerDelegate
    var loginDelegate: LoginViewControllerDelegate?

    private var userService: UserService? // Добавляем свойство для UserService
    
    let checkerService = CheckerService()
    
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
        view.placeholder = "Email"
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
        view.isSecureTextEntry = true
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
        let view = CustomButton(title: "Log In", color: UIColor(named: "ColorSet"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var singUpButton: CustomButton = {
        let view = CustomButton(title: "Sing Up", color: UIColor(named: "ColorSet"))
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
        loginField.text = "test@test.com"
        passwordField.text = "123456"
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
        loginButton.buttonAction = {[weak self] in
            self?.pushToProfile()
        }
        singUpButton.buttonAction = {[weak self] in
            self?.singUpProfile()
        }
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
        contentView.addSubview(singUpButton)
        
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
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            singUpButton.heightAnchor.constraint(equalToConstant: 50),
            singUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            singUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            singUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
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
    
    private func pushToProfile() {

        guard let login = loginField.text, !login.isEmpty, let password = passwordField.text, !password.isEmpty else {
            showAlert(alert: "Поля логин и пароль не должны быть пустыми")
            return
        }
        
        loginDelegate?.checkCredentials(email: login, password: password, completion: { result in
            switch result {
            case .failure(let error):
                if let errorMessage = self.errorMappings[error.localizedDescription] {
                    self.showAlert(alert: errorMessage)
                }
            case .success(let currentUser):
                if currentUser.user.email == "test@test.com" {
                    let user = self.userService?.getUser(byLogin: currentUser.user.email!)
                    self.coordinator?.showProfile(user!)
                } else {
                    self.showAlert(alert: "В тестовом режиме возможен вход только test@test.com")
                }
            }
        })
    }
    
    private func singUpProfile() {
        guard let login = loginField.text, !login.isEmpty, let password = passwordField.text, !password.isEmpty else {
            showAlert(alert: "Поля логин и пароль не должны быть пустыми")
            return
        }
        loginDelegate?.signUp(email: login, password: password) { result in
            switch result {
            case.failure(let error):
                if let errorMessage = self.errorMappings[error.localizedDescription] {
                    self.showAlert(alert: errorMessage)
                }
            case .success:
                self.showAlert(alert: "Пользователь успешно зарегистрирован")
            }
        }
    }
    
    let errorMappings: [String: String] = [
        "The email address is badly formatted.": "Адрес электронной почты имеет неправильный формат.",
        "There is no user record corresponding to this identifier. The user may have been deleted.": "Пользователя с таким Email не существует. Возможно, пользователь был удален. Пройдите регистрацию!",
        "The password is invalid or the user does not have a password.": "Введенный пароль недействительный",
        "The email address is already in use by another account.": "Адрес электронной почты уже используется другой учетной записью",
        "The password must be 6 characters long or more.": "Пароль должен иметь длину не менее 6 символов."
    ]
    
    private func showAlert(alert: String) {
        let alert = UIAlertController(title: "Ошибка", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
