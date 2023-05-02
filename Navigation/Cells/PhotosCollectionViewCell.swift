//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 24.03.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosCollectionViewCell"
    
    private lazy var photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        return photoView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        addSubviews()
        setConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(photoView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photoView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            photoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
     func updateContent(with photo: UIImage) {
         photoView.image = photo
    }
    
}
