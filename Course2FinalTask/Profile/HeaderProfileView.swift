//
//  HeaderProfileView.swift
//  Course2FinalTask
//
//  Created by Alexey Pavlov on 13.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class HeaderProfileView: UICollectionReusableView {

    static let identifier = "HeaderProfileView"

    var userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.contentMode = .scaleAspectFit
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userAvatar.layer.cornerRadius = 35
        userAvatar.clipsToBounds = true

        return userAvatar
    }()

    var userName: UILabel = {
        var userName = UILabel()
        userName.textAlignment = .left
        userName.font = UIFont.systemFont(ofSize: 14)
        userName.textColor = .black
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "sesdesvevdverve"
        return userName
    }()

    var followersTL: UILabel = {
        var followersTL = UILabel()
        followersTL.textAlignment = .left
        followersTL.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        followersTL.textColor = .black
        followersTL.translatesAutoresizingMaskIntoConstraints = false
        followersTL.isUserInteractionEnabled = true

        return followersTL
    }()

    var followingTL: UILabel = {
        var followingTL = UILabel()
        followingTL.textAlignment = .left
        followingTL.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        followingTL.textColor = .black
        followingTL.translatesAutoresizingMaskIntoConstraints = false
        followingTL.isUserInteractionEnabled = true

        return followingTL
    }()

    public func configure() {
        backgroundColor = .white
        addSubview(userAvatar)
        addSubview(userName)
        addSubview(followersTL)
        addSubview(followingTL)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        userAvatar.frame = bounds
        setupProfileViews()
    }

    func setupProfileViews() {
        NSLayoutConstraint.activate([userAvatar.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                 userAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                 userAvatar.widthAnchor.constraint(equalToConstant: 70),
                                 userAvatar.heightAnchor.constraint(equalToConstant: 70),

                                 userName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                 userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 8),

                                 followersTL.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 8),
                                 followersTL.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

                                 followingTL.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                 followingTL.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
                            ])
    }
        
}
