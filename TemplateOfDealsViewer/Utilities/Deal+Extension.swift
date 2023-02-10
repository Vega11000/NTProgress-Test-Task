//
//  Enum+Extension.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 10.02.2023.
//

import Foundation

extension Deal {
    var sideSortOrder: Int {
        switch side {
        case .buy:
            return 0
        case .sell:
            return 1
        }
    }
}
