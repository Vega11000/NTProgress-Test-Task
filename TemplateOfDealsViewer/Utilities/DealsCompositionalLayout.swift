//
//  DealsCompositionalLayout.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 06.02.2023.
//

import UIKit

enum DealsCompositionalLayout {
    static func generateLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [makeCollectionHeader()]
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { _, _  in
                return makeSection()
            },
            configuration: config
        )
    }
}

private extension DealsCompositionalLayout {
    static func makeCollectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .fractionalWidth(0.15)
            ),
            elementKind: SupplementaryViewsIdentifiers.collectionHeader,
            alignment: .top
        )
        header.contentInsets = .init(top: 0, leading: 14, bottom: 1, trailing: 14)
    
        return header
    }
    
    static func makeItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .fractionalWidth(0.2)
            )
        )
        item.contentInsets = .init(top: 0, leading: 20, bottom: 1, trailing: 0)
        
        return item
    }
    
    private static func makeGroup() -> NSCollectionLayoutGroup {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.2)
            ),
            subitems: [makeItem()]
        )
        
        group.contentInsets = .init(top: 0, leading: 2, bottom: 1, trailing: 2)
        
        return group
    }
    
    private static func makeSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeGroup())
        section.contentInsets = .init(
            top: 1,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
}
