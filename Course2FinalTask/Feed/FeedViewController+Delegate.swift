//
//  FeedViewController+Delegate.swift
//  Course2FinalTask
//
//  Created by Alexey Pavlov on 02.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
import DataProvider.Swift

struct LayoutConstants {
    
    static let topOffset: CGFloat = 8
    static let avatarHeight: CGFloat = 35
    static let topPostImageOffset: CGFloat = 8
    static let isLikeIconHeight: CGFloat = 44
    static let descriptionHeight: CGFloat = 44
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = view.bounds.width
        let imageHeight = width
        let height = LayoutConstants.topOffset + LayoutConstants.avatarHeight + LayoutConstants.topPostImageOffset + imageHeight + LayoutConstants.isLikeIconHeight + LayoutConstants.descriptionHeight

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
