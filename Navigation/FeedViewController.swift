
import UIKit

class FeedViewController: UIViewController {
    private let secondPost = Post(title: "PostViewController")

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Go to the post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Go to the post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(self.firstButton)
        stackView.addArrangedSubview(self.secondButton)
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
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)]) }

    @objc private func tapButton() {
        let postVC = PostViewController()
        postVC.post = secondPost
        navigationController?.pushViewController(postVC, animated: true)
    }
}
