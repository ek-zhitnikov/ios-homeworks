//
//  InfoViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "..."
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private let orbitalPeriodLabel: UILabel = {
        let view = UILabel()
        view.text = "..."
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private let showAlertButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Show message", for: .normal)
        view.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getTitle()
        getOrbitalPeriod()
    }
    
    private func setupView() {
        title = "Info"
        view.backgroundColor = .systemOrange
        view.addSubview(showAlertButton)
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        orbitalPeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showAlertButton.widthAnchor.constraint(equalToConstant: 200),
            showAlertButton.heightAnchor.constraint(equalToConstant: 50),
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: showAlertButton.topAnchor, constant: -50),
            
            orbitalPeriodLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            orbitalPeriodLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: 50)
        ])
    }
    
    private func getTitle() {
        NetworkService.downloadTitle { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titleText):
                    self?.titleLabel.text = titleText
                    self?.titleLabel.textColor = .black
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.titleLabel.text = "ошибка"
                    self?.titleLabel.textColor = .red
                }
            }
        }
    }
    
    private func getOrbitalPeriod() {
        NetworkService.downloadOrbitalPeriod { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let orbitalPeriod):
                    self?.orbitalPeriodLabel.text = "Tatuin orbital period \(orbitalPeriod) days"
                    self?.orbitalPeriodLabel.textColor = .black
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.orbitalPeriodLabel.text = "ошибка"
                    self?.orbitalPeriodLabel.textColor = .red
                }
            }
        }
    }
    
    @objc private func showAlert(_ sender: UIAlertController) {
        let alertController = UIAlertController(title: "Message", message: "Message", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            print("OK")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
