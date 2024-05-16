//
//  CategoryCollectionViewCell.swift
//  ShowMoney
//
//  Created by 이민재 on 5/14/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    private var label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "hi"
        return lb
    }()
    
    private func addView() {
        self.contentView.addSubview(label)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    private func configureColor() {
        self.backgroundColor = UIColor(named: "CellBackgroundColor")
        
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
    func configure(model: MainCategory) {
        self.label.text = model.name
    }
}
