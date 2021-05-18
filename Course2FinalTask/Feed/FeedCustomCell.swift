//
//  FeedCell.swift
//  Course2FinalTask
//
//  Created by Alexey Pavlov on 01.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
import DataProvider.Swift

protocol CellTappedDelegate: NSObjectProtocol {
    func showUserProfile(sender: User.Identifier)
    func showUsers(sender: [User])
}

class FeedCustomCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    var delegate: CellTappedDelegate?
    var postID: Post.Identifier?
    var userID: User.Identifier?

    var userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.image = DataProviders.shared.usersDataProvider.currentUser().avatar
        userAvatar.contentMode = .scaleAspectFit
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userAvatar.isUserInteractionEnabled = true

        return userAvatar
    }()
    
    var bigLike: UIImageView = {
        let bigLike = UIImageView()
        bigLike.image = UIImage(named: "bigLike")
        bigLike.contentMode = .scaleAspectFit
        bigLike.translatesAutoresizingMaskIntoConstraints = false
        bigLike.alpha = 0.0

        return bigLike
    }()

    var userName: UILabel = {
        var userName = UILabel()
        userName.textAlignment = .left
        userName.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        userName.textColor = .black
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.isUserInteractionEnabled = true
        
        return userName
    }()

    var postTime: UILabel = {
        var postTime = UILabel()
        postTime.textAlignment = .left
        postTime.font = UIFont.systemFont(ofSize: 14)
        postTime.textColor = .black
        postTime.translatesAutoresizingMaskIntoConstraints = false

        return postTime
    }()

    let postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.contentMode = .scaleAspectFit
        postImage.translatesAutoresizingMaskIntoConstraints = false

        return postImage
    }()
    
    var likesCountsLabel: UILabel = {
        let likesCountsLabel = UILabel()
        likesCountsLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        likesCountsLabel.textColor = .black
        likesCountsLabel.translatesAutoresizingMaskIntoConstraints = false
        likesCountsLabel.isUserInteractionEnabled = true
        
        return likesCountsLabel
    }()
    
    lazy var likeIcon: UIButton = {
        let likeIcon = UIButton()
        likeIcon.setImage(UIImage(named: "like"), for: .normal)
        likeIcon.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return likeIcon
    }()
    
    var postDescriptionLabel: UILabel = {
        var postDescriptionLabel = UILabel()
        postDescriptionLabel.textAlignment = .left
        postDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        postDescriptionLabel.textColor = .black
        postDescriptionLabel.numberOfLines = 0
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        return postDescriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didAddSubview(_ subview: UIView) {

        let postImageDoubleTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        postImageDoubleTap.numberOfTapsRequired = 2
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(postImageDoubleTap)

        let userNameTapped = UITapGestureRecognizer(target: self, action: #selector(userNameTap))
        userName.addGestureRecognizer(userNameTapped)
        
        let userAvatarTapped = UITapGestureRecognizer(target: self, action: #selector(userNameTap))
        userAvatar.addGestureRecognizer(userAvatarTapped)
        
        let likesTapped = UITapGestureRecognizer(target: self, action: #selector(showUsersLikesPost))
        likesCountsLabel.addGestureRecognizer(likesTapped)
    }
    
    @objc func likeTapped() {
        guard let postID = postID else { return }
        guard let post = DataProviders.shared.postsDataProvider.post(with: postID) else { return }
        if post.currentUserLikesThisPost {
            guard DataProviders.shared.postsDataProvider.unlikePost(with: postID) else { return }
            likeIcon.tintColor = .darkGray
            likesCountsLabel.text = "Likes: \(DataProviders.shared.postsDataProvider.post(with: postID)!.likedByCount)"
        } else {
            guard DataProviders.shared.postsDataProvider.likePost(with: postID) else { return }
            likeIcon.tintColor = .systemBlue
            likesCountsLabel.text = "Likes: \(DataProviders.shared.postsDataProvider.post(with: postID)!.likedByCount)"
        }
    }
    
    @objc func imageTapped() {
        guard let postID = postID else { return }
        guard let post = DataProviders.shared.postsDataProvider.post(with: postID) else { return }
        if post.currentUserLikesThisPost {
            guard DataProviders.shared.postsDataProvider.unlikePost(with: postID) else { return }
            likeIcon.tintColor = .darkGray
            likesCountsLabel.text = "Likes: \(DataProviders.shared.postsDataProvider.post(with: postID)!.likedByCount)"
        } else {
            guard DataProviders.shared.postsDataProvider.likePost(with: postID) else { return }
            likeIcon.tintColor = .systemBlue
            likesCountsLabel.text = "Likes: \(DataProviders.shared.postsDataProvider.post(with: postID)!.likedByCount)"
            bigLikeFadeInOut()
        }
    }
    
    @objc func bigLikeFadeInOut() {
        let animation = CAKeyframeAnimation()
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.76, 0, 0.24, 1)
        animation.duration = 0.6
        animation.keyTimes = [0, 0.1, 0.3, 0.6]
        animation.values = [0, 1, 1, 0]
        animation.keyPath = "opacity"
        bigLike.layer.add(animation, forKey: "opacity")
    }
    
    @objc func userNameTap() {
        guard let userID = userID else { return }
        delegate?.showUserProfile(sender: userID)
    }
    
    @objc func showUsersLikesPost() {
        delegate?.showUsers(sender: getUsersLikedPost())
    }
    
    func getUsersLikedPost() -> [User] {
        let currentUser = DataProviders.shared.usersDataProvider.currentUser()
        guard let postID = postID else { return [currentUser] }
        var users: [User] = []
        let usersId = DataProviders.shared.postsDataProvider.usersLikedPost(with: postID)
        usersId?.forEach { userID in
            guard let user = DataProviders.shared.usersDataProvider.user(with: userID) else { return }
            users.append(user)
        }
        
        return users
    }

    func setupViews() {
        postImage.addSubview(bigLike)
        contentView.addSubview(userAvatar)
        contentView.addSubview(userName)
        contentView.addSubview(postImage)
        contentView.addSubview(postTime)
        contentView.addSubview(likesCountsLabel)
        contentView.addSubview(postDescriptionLabel)
        contentView.addSubview(likeIcon)
        
        NSLayoutConstraint.activate([bigLike.centerYAnchor.constraint(equalTo: postImage.centerYAnchor),
                                     bigLike.centerXAnchor.constraint(equalTo: postImage.centerXAnchor),
                                     
                                     userAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                                     userAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                     userAvatar.widthAnchor.constraint(equalToConstant: 35),
                                     userAvatar.heightAnchor.constraint(equalToConstant: 35),

                                     userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                                     userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 8),
                                     
                                     postImage.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 8),
                                     postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                                     
                                     postTime.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -8),
                                     postTime.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 8),
                                       
                                     likeIcon.topAnchor.constraint(equalTo: postImage.bottomAnchor),
                                     likeIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                                     likeIcon.widthAnchor.constraint(equalToConstant: 44),
                                     likeIcon.heightAnchor.constraint(equalToConstant: 44),

                                     likesCountsLabel.centerYAnchor.constraint(equalTo: likeIcon.centerYAnchor),
                                     likesCountsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

                                     postDescriptionLabel.topAnchor.constraint(equalTo: likeIcon.bottomAnchor),
                                     postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                     postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                                     postDescriptionLabel.heightAnchor.constraint(equalToConstant: 44)
                                    ])
    }
}

// TODO: Должно упрощать делать констрейнты, но не точно
extension UIView {
    func noAutoresizingMask() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func anchorCustom(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeading: CGFloat = 0,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTrailing: CGFloat = 0) {
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
    }
}
