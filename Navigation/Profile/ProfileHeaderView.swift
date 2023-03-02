//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 27.02.2023.
//

import UIKit


class ProfileHeaderView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        let profilePhoto = UIImage(named: "cat")
        view.image = profilePhoto
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userName: UILabel = {
        let view = UILabel()
        view.text = "Playful Cat"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userStatus: UILabel = {
        let view = UILabel()
        view.text = "Do you think I'm playing games with you?"
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        view.setTitle("Show status", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required  init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(imageView)
        self.addSubview(userName)
        self.addSubview(statusButton)
        self.addSubview(userStatus)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            userName.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            statusButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            statusButton.leftAnchor.constraint(equalTo:leftAnchor, constant: 16),
            statusButton.rightAnchor.constraint(equalTo:rightAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            userStatus.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            userStatus.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userStatus.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
}

