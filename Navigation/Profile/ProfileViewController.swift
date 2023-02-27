//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 27.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //Создайте экземпляр класса ProfileHeaderView
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //добавьте profileHeaderView в качестве subview
        self.view.addSubview(profileHeaderView)
        
        // Изменение цвета
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    //в методе viewWillLayoutSubviews() задайте ему frame, равный frame корневого view
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let headerViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        profileHeaderView.frame = headerViewFrame
    }
}
    



