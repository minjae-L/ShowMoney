//
//  CollectionViewCell.swift
//  ShowMoney
//
//  Created by 이민재 on 4/14/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    var label: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    var expanded = false
    private func addView() {
        contentView.addSubview(label)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        configureConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
