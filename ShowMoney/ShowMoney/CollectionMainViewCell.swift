//
//  CollectionMainViewCell.swift
//  ShowMoney
//
//  Created by 이민재 on 4/16/24.
//

import UIKit

class CollectionMainViewCell: UICollectionViewCell {
    static let identifier = "CollectionMainViewCell"
    private var label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "hi"
        return lb
    }()
    
    func addView() {
        self.contentView.addSubview(label)
    }
    func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(model: MainCategory) {
        self.label.text = model.name
    }
}
