//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 23.03.2023.
//
import UIKit

final class PhotosTableViewCell: UITableViewCell {

    
    fileprivate let photos = PhotoModel.make()
    
    private enum Constants {
        static let spacing: CGFloat = 8
        static let offset: CGFloat = 12
        static let maxItemsInRow: CGFloat = 16
        static let minItemsInRow: CGFloat = 4
    }
    
    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.forward")
        arrow.tintColor = .black
        arrow.clipsToBounds = true
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    private lazy var photosCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.sectionInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        viewLayout.minimumLineSpacing = Constants.spacing
        let photosCollection = UICollectionView(frame: contentView.frame, collectionViewLayout: viewLayout)
        photosCollection.register(
            PhotoCell.self,
            forCellWithReuseIdentifier: PhotoCell.identifier)
        
        photosCollection.translatesAutoresizingMaskIntoConstraints = false
        return photosCollection
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .none
        accessoryView = nil
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(photosCollection)
        contentView.addSubview(arrowImage)
        
        photosCollection.dataSource = self
        photosCollection.delegate  = self
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.offset),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.offset),
            arrowImage.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            photosCollection.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Constants.offset),
            photosCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset),
            photosCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.offset),
            photosCollection.heightAnchor.constraint(equalToConstant: itemWidth(for: contentView.frame.width) + 1),
            
            contentView.bottomAnchor.constraint(equalTo: photosCollection.bottomAnchor, constant: Constants.offset - 1)
            
        ])

        
    }
    
    
    func setup(_ frame: CGRect) {
        contentView.frame = frame
        addSubviews()
        setConstraints()
    
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch photos.count {
        case 0:
            return 1
        case 0 ..< 4:
            return Int(Constants.minItemsInRow)
        case 5 ..< Int(Constants.maxItemsInRow):
            return photos.count
        default:
            return Int(Constants.maxItemsInRow)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        if photos.indices.contains(indexPath.row) {
            cell.updateContent(with: photos[indexPath.row])
        } else {
            cell.updateContent(with: "ImagePlaceholder" )
        }
        
        cell.contentView.layer.cornerRadius = 6
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat) -> CGFloat {
        
        let totalSpacing: CGFloat = 2 * Constants.offset + (Constants.minItemsInRow - 1) * Constants.spacing
        let finalWidth = (width - totalSpacing) / Constants.minItemsInRow
        
        return (finalWidth)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: contentView.frame.width)

        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spacing
    }
}
