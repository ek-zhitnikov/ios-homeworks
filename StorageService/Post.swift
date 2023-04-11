//
//  PostView.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 17.03.2023.
//

import UIKit

public struct Post {
    public let author: String
    public let description: String
    public let image: String
    public var likes: Int
    public var views: Int
}

public let post1 = Post(author: "Playful Cat", description: "7 классов музыкальной школы по классу фортепиано", image: "Plaing.jpg", likes: 100, views: 500)
public let post2 = Post(author: "Playful Cat", description: "Нравится ребенок, которого люди мне завели", image: "MyNewBaby.jpg", likes: 50, views: 200)
public let post3 = Post(author: "Playful Cat", description: "Провели прекрасные выходные с подружкой", image: "MyGiglfriend.jpg", likes: 200, views: 1000)
public let post4 = Post(author: "Playful Cat", description: "Ходил с мужиками на охоту", image: "Hunting.jpg", likes: 300, views: 800)

public var posts = [post1, post2, post3, post4]
