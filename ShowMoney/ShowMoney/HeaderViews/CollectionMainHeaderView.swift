//
//  CollectionHeaderView.swift
//  ShowMoney
//
//  Created by 이민재 on 4/14/24.
//

import UIKit

class CollectionMainHeaderView: UICollectionReusableView {
    static let identifier = "CollectionMainHeaderView"
    private var mainMoneyLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldSystemFont(ofSize: 20)
        lb.textAlignment = .center
        return lb
    }()
    private var timestampLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 15)
        lb.textAlignment = .center
        lb.text = "2024.04.27 ~ 2024.04.30"
        return lb
    }()
    
    private func addView() {
        addSubview(mainMoneyLabel)
        addSubview(timestampLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainMoneyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainMoneyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timestampLabel.topAnchor.constraint(equalTo: mainMoneyLabel.bottomAnchor, constant: 10),
            timestampLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .systemPink
        addView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(model: MainSectionModel) {
        self.mainMoneyLabel.text = model.moneyGoal
    }
}