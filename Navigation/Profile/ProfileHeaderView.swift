//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 27.02.2023.
//

import UIKit


class ProfileHeaderView: UIView {
    
    /*private*/ let avatarImageView: UIImageView = {
        let view = UIImageView()
//        let profilePhoto = UIImage(named: "logo")
//        view.image = profilePhoto
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fullNameLabel: UILabel = {
        let view = UILabel()
//        view.text = "TEST"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusLabel: UILabel = {
        let view = UILabel()
//        view.text = "TEST"
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let setStatusButton: UIButton = {
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
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusLabel)
        self.backgroundColor = .systemGray6
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
       
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
       
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leftAnchor.constraint(equalTo:leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo:rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
       
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        guard let userStatus = statusLabel.text else { return }
        print("\(userStatus)")
    }
    
    @objc private func avatarTapped() {
        
        let screenWidth = UIScreen.main.bounds.width
        let scale = screenWidth / avatarImageView.frame.width
        
        // создаем полупрозрачную view
        let overlayView = UIView(frame: bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.alpha = 0
        addSubview(overlayView)
        
        // создаем кнопку с крестиком
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.alpha = 0
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addSubview(closeButton)
        
        // анимация перемещения аватара в центр экрана и растягивания
        UIView.animate(withDuration: 0.5, animations: {
            self.avatarImageView.center = self.center
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            overlayView.alpha = 1
        }, completion: { finished in
            // анимация появления кнопки с крестиком
            UIView.animate(withDuration: 0.3) {
                closeButton.alpha = 1
            }
        })
    }
    @objc func closeButtonTapped() {
        let scale = avatarImageView.frame.width / UIScreen.main.bounds.width
        
        // находим полупрозрачную view и кнопку с крестиком
        guard let overlayView = subviews.first(where: { $0 is UIView && $0.alpha == 1 }),
              let closeButton = subviews.first(where: { $0 is UIButton && $0.alpha == 1 })
        else {
            return
        }
        
        // анимация скрытия кнопки с крестиком
        UIView.animate(withDuration: 0.3, animations: {
            closeButton.alpha = 0
        }, completion: { finished in
            // анимация возвращения аватара в начальное положение и скрытия view
            UIView.animate(withDuration: 0.5, animations: {
                self.avatarImageView.center = CGPoint(x: self.frame.width / 2, y: 66)
                self.avatarImageView.transform = CGAffineTransform.identity
                overlayView.alpha = 0
            })
        }
        )}
    
    func setup(user: User) {
        avatarImageView.image = user.avatar
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
    }

}

