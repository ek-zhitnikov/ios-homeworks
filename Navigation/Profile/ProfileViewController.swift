//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 27.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let postCellIdentifire = "postCell"
    let photoCellIdentifire = "photoCell"
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupTable() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postCellIdentifire)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoCellIdentifire)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupUI()
        setupTable()
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
    }
    
    func setupUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
extension ProfileViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = ProfileHeaderView()
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0{
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}
    
    extension ProfileViewController: UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0:
                return 1
            case 1:
                return posts.count
            default:
                break
            }
            return 0
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifire, for: indexPath) as! PhotosTableViewCell
                cell.setup(tableView.bounds)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifire, for: indexPath) as! PostTableViewCell
                let post = posts[indexPath.row]
                cell.refresh(post)
                return cell
            default:
                break
            }
            
            return UITableViewCell()
        }
        
    }
    

    



