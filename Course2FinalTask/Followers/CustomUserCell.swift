//
//  CustomUserCell.swift
//  Course2FinalTask
//
//  Created by Alexey Golovin on 11.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class CustomUserCell: UITableViewCell {

    
    var userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        return userAvatar
    }()
    
    var userNameTL: UILabel = {
        let userNameTL = UILabel()
        userNameTL.translatesAutoresizingMaskIntoConstraints = false
        
        return userNameTL
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomUserCell {
    func setupViews() {
        contentView.addSubview(userAvatar)
        contentView.addSubview(userNameTL)
        NSLayoutConstraint.activate([contentView.heightAnchor.constraint(equalToConstant: 45),
                                     userAvatar.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     userAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                     userAvatar.heightAnchor.constraint(equalToConstant: 45),
                                     userAvatar.widthAnchor.constraint(equalToConstant: 45),
                                     
                                     userNameTL.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 16),
                                     userNameTL.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//                                     userNameTL.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     
        ])
    }
}
