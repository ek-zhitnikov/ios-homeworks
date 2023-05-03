
import UIKit

class FeedViewController: UIViewController, UITextFieldDelegate {
    private let secondPost = FirstPost(title: "PostViewController")
    private let feedModel = FeedModel()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Go to the post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Go to the post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var newTextField: UITextField = {
        let view = CustomTextField()
        view.textColor = .black
        view.backgroundColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.placeholder = "Введи пароль"
        view.autocapitalizationType = .none
        view.returnKeyType = .done
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.delegate = self
        return view
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let view = CustomButton(title: "Проверить")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.buttonAction = { [weak self] in

            self?.newTextField.endEditing(true)

            guard let text = self?.newTextField.text else { return }
            guard text != "" else { return }
            guard let checkResult = self?.feedModel.check(text) else { return }

            self?.didCheckGuess(checkResult)
        }
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
//        stackView.addArrangedSubview(self.firstButton)
//        stackView.addArrangedSubview(self.secondButton)
        stackView.addArrangedSubview(self.label)
        stackView.addArrangedSubview(self.newTextField)
        stackView.addArrangedSubview(self.checkGuessButton)
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func tapButton() {
        let postVC = PostViewController()
        postVC.post = secondPost
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    private func didCheckGuess(_ isTrue: Bool) {
        
        guard let secretWord = newTextField.text else { return }
        let isValid = feedModel.check(secretWord)

        if isValid {
            self.label.backgroundColor = .green
            self.label.text = "Верно"

        } else {
            self.label.backgroundColor = .red
            self.label.text = "Ошибка"

        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.updateUI()
        }
    }
    @objc func updateUI(){
        DispatchQueue.main.async {
            self.label.backgroundColor = .clear
            self.label.text = ""
        }
    }
    
}
