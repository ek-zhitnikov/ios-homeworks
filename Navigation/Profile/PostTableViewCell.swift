//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.03.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private lazy var postTitle: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 2

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var postImage: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .black

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var postText: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .systemGray
        view.sizeToFit()
        view.numberOfLines = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likesLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .black
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewsLabel: UILabel = {
        let views = UILabel()
        views.font = .systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(postTitle)
        contentView.addSubview(postImage)
        contentView.addSubview(postImage)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
                   postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                   postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   
                   postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 16),
                   postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                   postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
                   
                   postText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
                   postText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   postText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   
                   likesLabel.topAnchor.constraint(equalTo: postText.bottomAnchor),
                   likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   
                   viewsLabel.topAnchor.constraint(equalTo: postText.bottomAnchor),
                   viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   contentView.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 16)
                   
               ])
    }
}
