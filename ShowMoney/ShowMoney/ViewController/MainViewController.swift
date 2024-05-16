//
//  MainViewController.swift
//  ShowMoney
//
//  Created by 이민재 on 5/14/24.
//

import UIKit

class MainViewController: UIViewController {
//    MARK: UI Property
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .gray
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        cv.register(CollectionMainHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionMainHeaderView.identifier)
        
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        configureLayout()
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }
    private func addView() {
        view.addSubview(mainCollectionView)
    }
    private func configureLayout() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    private func configureColor() {
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sample.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                                for: indexPath) as? MainCollectionViewCell else {
            print("Fail")
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.configure(indexPath.row)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionMainHeaderView.identifier, for: indexPath) as? CollectionMainHeaderView else { return UICollectionReusableView() }
            switch Sample.data[0] {
            case .category(let model):
                header.configure(model: model)
            case .moneyTable:
                break
            }
            
            return header
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
        default:
            print("MainVC Header & Footer binding Fail")
            return UICollectionReusableView()
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: self.view.frame.width, height: 50)
        } else {
            switch Sample.data[indexPath.row] {
            case .category(let model):
                return CGSize(width: self.view.frame.width, height: 50)
            case .moneyTable(let model):
                if model.expanded {
                    return CGSize(width: self.view.frame.width, height: CGFloat((model.payModel.count+1) * 100 + ((model.payModel.count - 1) * 10 )))
                } else {
                    return CGSize(width: self.view.frame.width, height: 100)
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewController: MainCollectionViewCellDelegate {
    func headerViewDidTapped(index: Int) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.mainCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            })
        }
    }
    
}
