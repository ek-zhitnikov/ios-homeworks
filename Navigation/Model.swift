//
//  Model.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//


import Foundation

struct FirstPost {
    var title: String
}

func main() {

    let myPost = FirstPost(title: "New post")

    let postViewController = PostViewController()

    postViewController.post = myPost
}
