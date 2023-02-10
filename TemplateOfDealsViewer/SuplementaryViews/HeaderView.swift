//
//  HeaderView.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 09.02.2023.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    private let instrumentNameTitlLabel: UILabel = {
        let label = UILabel()
        label.text = "Instrument"
        label.font = .systemFont(ofSize: FontSize.small)
        return label
    }()
    
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = .systemFont(ofSize: FontSize.small)
        return label
    }()
    
    private let amountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = .systemFont(ofSize: FontSize.small)
        return label
    }()
    
    private let sideTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Side"
        label.font = .systemFont(ofSize: FontSize.small)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    
    private enum Constants {
        static let padding: CGFloat = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension HeaderView {
    
    func addSubviews() {
        stackView.addArrangedSubview(instrumentNameTitlLabel)
        stackView.addArrangedSubview(priceTitleLabel)
        stackView.addArrangedSubview(amountTitleLabel)
        stackView.addArrangedSubview(sideTitleLabel)
        addSubview(stackView)
    }
    
    func addConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1.5 * Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.5 * Constants.padding)
        ])
    }
}
