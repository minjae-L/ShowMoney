//
//  CollectionSubHeaderView.swift
//  ShowMoney
//
//  Created by 이민재 on 4/15/24.
//

import UIKit

protocol CollectionSubHeaderViewDelegate: AnyObject {
    func resizeSection(sectionIndex: Int)
}

class CollectionSubHeaderView: UICollectionReusableView {
    static let identifier = "CollectionSubHeaderView"
    weak var delegate: CollectionSubHeaderViewDelegate?
    var index = 0
    
//    MARK: UI Property
    private let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 15)
        lb.numberOfLines = 0
        
        return lb
    }()
    
    private var totalMoneylabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldSystemFont(ofSize: 25)
        lb.numberOfLines = 0
        
        return lb
    }()
    private var percentLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldSystemFont(ofSize: 15)
        lb.numberOfLines = 0
        return lb
    }()
    private let addButton: UIButton = {
        let btn = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        btn.setImage(UIImage(systemName: "plus", withConfiguration: imageConfig), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFill
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        return btn
    }()
    
//    MARK: Stack View Property
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.alignment = .leading
        sv.distribution = .fillEqually
        return sv
    }()
    private var innerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 15
        sv.alignment = .trailing
        sv.distribution = .equalSpacing
        return sv
    }()
    
//    MARK: Method
    private func addView() {
        addSubview(stackView)
        addSubview(addButton)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(innerStackView)
        innerStackView.addArrangedSubview(totalMoneylabel)
        innerStackView.addArrangedSubview(percentLabel)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -10),
            categoryLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            innerStackView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            totalMoneylabel.topAnchor.constraint(equalTo: innerStackView.topAnchor),
            percentLabel.topAnchor.constraint(equalTo: innerStackView.topAnchor),
            totalMoneylabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor, constant: -15),
            percentLabel.leadingAnchor.constraint(equalTo: innerStackView.trailingAnchor, constant: -50)
        ])
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    private func configureColor() {
        categoryLabel.textColor = UIColor(named: "LabelTextColor")
        totalMoneylabel.textColor = UIColor(named: "LabelTextColor")
        percentLabel.textColor = UIColor(named: "LabelTextColor")
        stackView.backgroundColor = UIColor(named: "CellBackgroundColor")
        innerStackView.backgroundColor = UIColor(named: "CellBackgroundColor")
        self.backgroundColor = UIColor(named: "CellBackgroundColor")
    }
    private func addEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    // 셀 확장 축소 기능
    @objc func headerViewTapped() {
        print("headerview tapped")
        delegate?.resizeSection(sectionIndex: index)
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        configureConstraints()
        addEvent()
        configureColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(model: SubSectionModel) {
        self.categoryLabel.text = model.categoryName
        self.totalMoneylabel.text = String(model.totalMoney)
        self.percentLabel.text = String(model.percent)
    }
}
