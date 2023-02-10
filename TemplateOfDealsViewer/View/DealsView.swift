//
//  DealsView.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 06.02.2023.
//

import UIKit

final class DealsView: UIView {
    
    var dealsList: [Deal] = []
    private var upDeals = false
    private var sortFieldState = SortFields.date
    
    private enum SortFields: String, CaseIterable {
        case instrument = "Instrument"
        case price = "Price"
        case amount = "Amount"
        case side = "Side"
        case date = "Date"
    }
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: DealsCompositionalLayout.generateLayout()
    )
    
    lazy var upDownDealsBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.primaryAction = UIAction { [weak self] _ in if let self {
            self.upDeals.toggle()
            button.image = self.upDeals ?
            UIImage(systemName: "arrowtriangle.up.fill") :
            UIImage(systemName: "arrowtriangle.down.fill")
            self.sortDealsList()
        }
        }
        button.image = UIImage(systemName: "arrowtriangle.down.fill")
        return button
    }()
    
    private lazy var sortMenu: UIMenu = {
        let sortActions = SortFields.allCases.map { field in
            return UIAction(title: field.rawValue) { _ in
                self.sortFieldState = field
                self.sortDealsList()
            }
        }
        let devider = UIMenu(title: "Sort By", options: .displayInline, children: sortActions)
        let items = [devider]
        let menu = UIMenu(children: items)
        return menu
    }()
    
    lazy var sortBarButton: UIBarButtonItem = {
        let barItem = UIBarButtonItem()
        barItem.menu = sortMenu
        return barItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        prepareCollectionView()
        configureRefreshControl()
        sortDealsList()
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
    func sortDealsList() {
        switch sortFieldState {
        case .instrument:
            sortBarButton.title = SortFields.instrument.rawValue
            dealsList.sort { $0.instrumentName < $1.instrumentName }
        case .price:
            sortBarButton.title = SortFields.price.rawValue
            dealsList.sort { $0.price < $1.price }
        case .amount:
            sortBarButton.title = SortFields.amount.rawValue
            dealsList.sort { $0.amount < $1.amount }
        case .side:
            sortBarButton.title = SortFields.side.rawValue
            dealsList.sort { $0.sideSortOrder < $1.sideSortOrder }
        case .date:
            sortBarButton.title = SortFields.date.rawValue
            dealsList.sort { $0.dateModifier < $1.dateModifier }
        }
        
        if upDeals {
            dealsList.reverse()
        }
        
        collectionView.reloadData()
    }
    
    func configureRefreshControl () {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc
    func handleRefreshControl() {
        DispatchQueue.main.async { [self] in
            collectionView.refreshControl?.endRefreshing()
            sortDealsList()
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
