//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Alexey Golovin on 25.06.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//
import UIKit
import DataProvider
import DataProvider.Swift

class ProfileViewController: UIViewController {
    
    var receivedUser: User = DataProviders.shared.usersDataProvider.currentUser()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white 
        collectionView.register(HeaderProfileView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderProfileView.identifier)
        collectionView.register(CustomProfileCell.self,
                                forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupProfileViews()
        self.title = receivedUser.username
    }

    func setupProfileViews() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: HeaderProfileView.identifier,
                                                                     for: indexPath) as! HeaderProfileView

        header.configure()

        let followersTLTap = UITapGestureRecognizer(target: self,
                                                    action: #selector(followersTLTapped))
        header.followersTL.addGestureRecognizer(followersTLTap)

        let followedTLTap = UITapGestureRecognizer(target: self,
                                                   action: #selector(followedTLTapped))
        header.followingTL.addGestureRecognizer(followedTLTap)

        header.userAvatar.image = receivedUser.avatar
        header.userName.text = receivedUser.fullName
        header.followersTL.text = "Followers: \(receivedUser.followedByCount)"
        header.followingTL.text = "Following: \(receivedUser.followsCount)"

        return header
    }
}

extension ProfileViewController {
    @objc func followersTLTapped() {
        let nextVC = UsersTableViewController()
        guard let users: [User] = DataProviders.shared.usersDataProvider.usersFollowingUser(with: receivedUser.id) else { return }
        nextVC.receivedUser = users
        nextVC.tableTitle = "Followers"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func followedTLTapped() {
        let nextVC = UsersTableViewController()
        guard let users: [User] = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: receivedUser.id) else { return }
        nextVC.receivedUser = users
        nextVC.tableTitle = "Following"
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
