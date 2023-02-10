//
//  DealsCell.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 06.02.2023.
//

import UIKit

final class DealsCell: UICollectionViewCell {
    
    private let dateFormatter = DateFormatter()
    
    var deal: Deal? {
        didSet {
            instrumentNameLabel.text = deal?.instrumentName
            priceLabel.text = String(format: "%.3f", deal?.price ?? 0)
            amountLabel.text = String(format: "%.0f", deal?.amount ?? 0)
            
            setDealSideValue(side: deal?.side ?? .sell)
            
            dateFormatter.dateFormat = "HH:mm:ss dd.MM.yy"
            dateLabel.text = dateFormatter.string(from: deal?.dateModifier ?? Date.now)
        }
    }
    
    private lazy var instrumentNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.large)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.large)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.large)
        return label
    }()
    
    private lazy var sideLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = label.text == "Sell" ? .red : .green
        label.font = .systemFont(ofSize: FontSize.large)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: FontSize.medium)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    
    private enum Constants {
        static let padding: CGFloat = 25
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

private extension DealsCell {
    
    func addSubviews() {
        stackView.addArrangedSubview(instrumentNameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(sideLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(stackView)
    }
    
    func addConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding / 2),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            
            stackView.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: Constants.padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding / 2),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding)
        ])
    }
    
    func setDealSideValue(side: Deal.Side) {
        switch side {
        case .sell:
            sideLabel.text = "Sell"
            sideLabel.textColor = .red
        case .buy:
            sideLabel.text = "Buy"
            sideLabel.textColor = .green
        }
    }
}
