//
//  CollectionSubHeaderView.swift
//  ShowMoney
//
//  Created by 이민재 on 4/15/24.
//

import UIKit

protocol CollectionSubHeaderViewDelegate: AnyObject {
    func resizeSection()
}

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
    weak var delegate: CollectionSubHeaderViewDelegate?
    
    private func addView() {
        addSubview(label)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func addEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    @objc func headerViewTapped() {
        print("headerview tapped")
        delegate?.resizeSection()
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        configureConstraints()
        addEvent()
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
