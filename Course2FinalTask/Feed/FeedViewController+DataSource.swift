//
//  FeedViewController+DataSource.swift
//  Course2FinalTask
//
//  Created by Alexey Pavlov on 02.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
import DataProvider.Swift

let cellId = "cellId"

let users = DataProviders.shared.usersDataProvider.usersFollowingUser(with: DataProviders.shared.usersDataProvider.currentUser().id)

let posts = DataProviders.shared.postsDataProvider.feed()

func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
}

extension FeedViewController: UICollectionViewDataSource, CellTappedDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCustomCell
        cell.postID = posts[indexPath.item].id
        cell.userID = posts[indexPath.item].author
        cell.userName.text = posts[indexPath.item].authorUsername
        cell.userAvatar.image = posts[indexPath.item].authorAvatar
        if getFormattedDate(date: posts[indexPath.item].createdTime, format: "MMM d, YYYY") == getFormattedDate(date: Date(), format: "MMM d, YYYY") {
            cell.postTime.text = "Today at " + getFormattedDate(date: posts[indexPath.item].createdTime, format: "h:mm:ss a")
        } else {
            cell.postTime.text = getFormattedDate(date: posts[indexPath.item].createdTime, format: "MMM d, YYYY") + " at " + getFormattedDate(date: posts[indexPath.item].createdTime, format: "h:mm:ss a")
        }
        cell.postImage.image = posts[indexPath.item].image
        cell.likesCountsLabel.text = "Likes: \(posts[indexPath.item].likedByCount)"
        cell.postDescriptionLabel.text = posts[indexPath.item].description
        if posts[indexPath.item].currentUserLikesThisPost != true {
        cell.likeIcon.tintColor = .darkGray
        }
        cell.backgroundColor = .white
        cell.delegate = self
        
        return cell
    }
    
    func showUserProfile(sender: User.Identifier) {
        let profileView = ProfileViewController()
        guard let user = DataProviders.shared.usersDataProvider.user(with: sender) else { return }
//        tabBarController?.selectedIndex = 1
        profileView.receivedUser = user
//        print(profileView.receivedUser)
        navigationController?.pushViewController(profileView, animated: true)
    }
    
    func showUsers(sender: [User]) {
        let tableView = UsersTableViewController()
        tableView.receivedUser = sender
        tableView.tableTitle = "Likes"
        navigationController?.pushViewController(tableView, animated: true)
    }
    
    
}
