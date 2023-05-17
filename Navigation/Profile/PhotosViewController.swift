//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 24.03.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    // photos - массив моделей фотографий
    fileprivate var photos: [UIImage] = PhotoModel.make()
    
    /*    // Создайте для PhotosViewController экземпляр класса ImagePublisherFacade
     private let imagePublisherFacade = ImagePublisherFacade()
     */
    //
    private let imageProcessor = ImageProcessor()
    
    // cellIdentifire - идентификатор ячейки коллекции
    let cellIdentifire = "photoCellIdentifire"
    
    // sectionInsets - отступы между секциями коллекции
    let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    // itemsPerRow - количество элементов в ряду коллекции
    let itemsPerRow: CGFloat = 3
    
    // collectionView - коллекция для отображения фотографий
    private lazy var collectionView: UICollectionView = {
        // layout - настройка внешнего вида коллекции
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = sectionInsets.left
        layout.minimumLineSpacing = sectionInsets.left
        
        // width - вычисление ширины ячейки в коллекции
        let width = (view.frame.width - (sectionInsets.left + sectionInsets.right + layout.minimumInteritemSpacing * (itemsPerRow - 1))) / itemsPerRow
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = sectionInsets
        
        // collectionView - создание коллекции с настройками и регистрацией ячеек
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        // установка видимости навигационной панели
        navigationController?.navigationBar.isHidden = false
        // настройка заголовка в навигационной панели
        let titleLabel = UILabel()
        titleLabel.text = "Photo Gallery"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        navigationItem.titleView = titleLabel
        
        /*       // Подписываемся на обновления изображений, чтобы обновлять нашу коллекцию
         imagePublisherFacade.subscribe(self)
         imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: photos.count, userImages: photos)
         */
        processImagesOnThread()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        /*        imagePublisherFacade.rechargeImageLibrary()
         imagePublisherFacade.removeSubscription(for: self)
         */
    }
    
    private func processImagesOnThread() {
        DispatchQueue.global(qos: .utility).sync {
            let startTime = Date().timeIntervalSince1970
            
            self.imageProcessor.processImagesOnThread(sourceImages: self.photos,
                                                 filter: .chrome,
                                                      qos: .background,
                                                 completion: {images in
                
                DispatchQueue.main.sync {
                    
                    self.photos = images.map {
                        guard let cgImage = $0 else {fatalError("something went wrong while getting images")}
                        return UIImage(cgImage: cgImage)
                    }
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                    let endTime = Date().timeIntervalSince1970
                    let elapsedTime = endTime - startTime
                    print(elapsedTime)
                }
                
            })
        }
    }
}
//    3.377690076828003 qos: .default
//    3.329916000366211 qos: .background
//    2.9145679473876953 qos: .userInitiated
//    3.0211479663848877 qos: .userInteractive
//    3.2839410305023193 qos: .utility


extension PhotosViewController: UICollectionViewDataSource {
    // numberOfItemsInSection - метод, возвращающий количество элементов в коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    // cellForItemAt - метод, возвращающий ячейку для элемента
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell

        cell.updateContent(with: photos[indexPath.row])
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    // layout - метод, возвращиющи отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

/*extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.photos = images
        // Обновляем коллекцию с новыми фотографиями
        self.collectionView.reloadData()
    }
}
*/
