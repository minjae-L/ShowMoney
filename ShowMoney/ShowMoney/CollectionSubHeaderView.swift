//
//  CollectionSubHeaderView.swift
//  ShowMoney
//
//  Created by 이민재 on 4/15/24.
//

import UIKit

class CollectionSubHeaderView: UICollectionReusableView {
    static let identifier = "CollectionSubHeaderView"
    private let label: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldSystemFont(ofSize: 20)
        lb.numberOfLines = 0
        lb.text = "2,000,000"
        return lb
    }()
    
    private func addView() {
        addSubview(label)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        configureConstraints()
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
