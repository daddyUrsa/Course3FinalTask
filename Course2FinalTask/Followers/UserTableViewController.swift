//
//  UserTableViewController.swift
//  Course2FinalTask
//
//  Created by Alexey Pavlov on 10.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
import DataProvider.Swift

class UsersTableViewController: UITableViewController {

    var receivedUser: [User] = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: DataProviders.shared.usersDataProvider.currentUser().id)!
    
    var tableTitle: String = ""
    
    let tableCellId = "tableCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tableTitle
        tableView.register(CustomUserCell.self, forCellReuseIdentifier: tableCellId)
        
//        let cellTap = UITapGestureRecognizer(target: self, action: #selector())
    }
}

extension UsersTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomUserCell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! CustomUserCell
        let currentLastItem = receivedUser[indexPath.row]
        cell.userNameTL.text = currentLastItem.fullName
        cell.userAvatar.image = currentLastItem.avatar
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedUser.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileView = ProfileViewController()
        profileView.receivedUser = receivedUser[indexPath.row]
        navigationController?.pushViewController(profileView, animated: true)
    }
    
}


