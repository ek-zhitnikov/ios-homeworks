//
//  Model.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.02.2023.
//


import Foundation

struct Post {
    var title: String
}

func main() {

    let myPost = Post(title: "New post")

    let postViewController = PostViewController()

    postViewController.post = myPost
}
