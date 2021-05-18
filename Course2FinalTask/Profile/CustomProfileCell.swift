//
//  CustomProfileCell.swift
//  Course2FinalTask
//
//  Created by Alexey Golovin on 03.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class CustomProfileCell: UICollectionViewCell {

    var postImageCell: UIImageView = {
        let postImageCell = UIImageView()
        postImageCell.contentMode = .scaleAspectFit
        postImageCell.translatesAutoresizingMaskIntoConstraints = false
        return postImageCell
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        contentView.addSubview(postImageCell)
        NSLayoutConstraint.activate([postImageCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     postImageCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     postImageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     postImageCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
