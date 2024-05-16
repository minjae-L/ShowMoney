//
//  MoneyCollectionViewCell.swift
//  ShowMoney
//
//  Created by 이민재 on 5/14/24.
//

import UIKit

class MoneyCollectionViewCell: UICollectionViewCell {
    static let identifier = "MoneyCollectionViewCell"
//    MARK: UI Property
    private var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    private var moneyLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 16)
        return lb
    }()
//    MARK: Method
    private func addView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(moneyLabel)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -100),
            moneyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            moneyLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            moneyLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            moneyLabel.leadingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor,constant: -100)
            ])
    }
    private func configureColor() {
        self.backgroundColor = UIColor(named: "CellInCellColor")
        nameLabel.textColor = UIColor(named: "LabelTextColor")
        moneyLabel.textColor = UIColor(named: "LabelTextColor")
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        configureConstraints()
        configureColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(model: PayModel) {
        self.nameLabel.text = model.name
        self.moneyLabel.text = String(model.money)
    }
    
}
