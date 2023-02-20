//
//  InfoViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//

import UIKit

class InfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setTitle()
        setBackgroundColor()
        addButton()
    }
    
    private func setTitle() {
        title = "Info"
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = .systemOrange
    }
    
    private func addButton() {
        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle("Show message", for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        view.addSubview(showAlertButton)
        addConstraints(to: showAlertButton)
    }
    
    private func addConstraints(to button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func showAlert() {
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
