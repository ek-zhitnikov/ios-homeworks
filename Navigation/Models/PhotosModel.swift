//
//  PhotosModel.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 23.03.2023.
//

import Foundation

struct PhotoModel {
    let imageName: String
}

extension PhotoModel {
    static func make() -> [PhotoModel]{
        [
            PhotoModel(imageName: "1"),
            PhotoModel(imageName: "2"),
            PhotoModel(imageName: "3"),
            PhotoModel(imageName: "4"),
            PhotoModel(imageName: "5"),
            PhotoModel(imageName: "6"),
            PhotoModel(imageName: "7"),
            PhotoModel(imageName: "8"),
            PhotoModel(imageName: "9"),
            PhotoModel(imageName: "10"),
            PhotoModel(imageName: "11"),
            PhotoModel(imageName: "12"),
            PhotoModel(imageName: "13"),
            PhotoModel(imageName: "14"),
            PhotoModel(imageName: "15"),
            PhotoModel(imageName: "16"),
            PhotoModel(imageName: "17"),
            PhotoModel(imageName: "18"),
            PhotoModel(imageName: "19"),
            PhotoModel(imageName: "20")
            
        ]
    }
}
