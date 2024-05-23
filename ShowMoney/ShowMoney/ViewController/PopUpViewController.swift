//
//  PopUpViewController.swift
//  ShowMoney
//
//  Created by 이민재 on 5/23/24.
//

import UIKit

class PopUpViewController: UIViewController {
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "설정"
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    private let dateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "종료 날짜"
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.locale = Locale(identifier: "ko_KR")
        dp.preferredDatePickerStyle = .compact
        dp.datePickerMode = .date
        
        return dp
    }()
    private let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    private let configureDateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 20
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configureLayout()
        configureColor()
    }
    private func addViews() {
        configureDateStackView.addArrangedSubview(dateLabel)
        configureDateStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(configureDateStackView)
        self.view.addSubview(contentStackView)
    }
    private func configureLayout() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
        ])
    }
    private func configureColor() {
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        contentStackView.backgroundColor = .cyan
        configureDateStackView.backgroundColor = .brown
    }
}
