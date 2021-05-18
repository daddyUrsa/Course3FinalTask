//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Alexey Pavlov on 02.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
import DataProvider.Swift

class FeedViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightGray
        collectionView.register(FeedCustomCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension FeedViewController {

    func setupViews() {
        navigationController?.navigationBar.topItem?.title = "Feed"
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

