//
//  PostView.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.03.2023.
//

import UIKit

struct NewPost {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
}

let post1 = NewPost(author: "Playful Cat", description: "7 классов музыкальной школы по классу фортепиано", image: "Plaing.jpg", likes: 100, views: 500)
let post2 = NewPost(author: "Playful Cat", description: "Нравится ребенок, которого люди мне завели", image: "MyNewBaby.jpg", likes: 50, views: 200)
let post3 = NewPost(author: "Playful Cat", description: "Провели прекрасные выходные с подружкой", image: "MyGiglfriend.jpg", likes: 200, views: 1000)
let post4 = NewPost(author: "Playful Cat", description: "Ходил с мужиками на охоту", image: "Hunting.jpg", likes: 300, views: 800)

var posts = [post1, post2, post3, post4]
