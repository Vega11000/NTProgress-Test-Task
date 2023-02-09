//
//  DealsView.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 06.02.2023.
//

import UIKit

protocol DealsViewDelegate: AnyObject {}

final class DealsView: UIView {
    
    weak var viewDelegate: DealsViewDelegate?
    var dealsList: [Deal] = []
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: DealsCompositionalLayout.generateLayout()
    )
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        prepareCollectionView()
        configureRefreshControl()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DealsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dealsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SupplementaryViewsIdentifiers.dealsCell,
            for: indexPath
        ) as? DealsCell else {
            fatalError("Wrong cell class dequeued")
        }
        
        cell.deal = dealsList[indexPath.item]
        cell.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: kind,
            for: indexPath
        )
        
        cell.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        return cell
    }
}

private extension DealsView {
    
    func configureRefreshControl () {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc
    func handleRefreshControl() {
        DispatchQueue.main.async { [self] in
            collectionView.refreshControl?.endRefreshing()
            collectionView.reloadData()
        }
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(DealsCell.self, forCellWithReuseIdentifier: SupplementaryViewsIdentifiers.dealsCell)
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: SupplementaryViewsIdentifiers.collectionHeader,
            withReuseIdentifier: SupplementaryViewsIdentifiers.collectionHeader
        )
        addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }
}
