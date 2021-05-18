//
//  ProfileViewController+DataSource.swift
//  Course2FinalTask
//
//  Created by Alexey Golovin on 03.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
import DataProvider.Swift

let cellID = "cellId"

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let posts = DataProviders.shared.postsDataProvider.findPosts(by: receivedUser.id) else { return 0}
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomProfileCell
        guard let currentUserPosts = currentUserPost(user: receivedUser) else { return cell }
        cell.postImageCell.image = currentUserPosts[indexPath.item].image
        return cell
    }
    
    func currentUserPost(user: User) -> [Post]? {
        let currentUser = receivedUser.id
        return DataProviders.shared.postsDataProvider.findPosts(by: currentUser)
    }


}
