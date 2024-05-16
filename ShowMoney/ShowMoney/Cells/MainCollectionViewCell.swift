//
//  MainCollectionViewCell.swift
//  ShowMoney
//
//  Created by 이민재 on 5/14/24.
//

import UIKit

protocol MainCollectionViewCellDelegate: AnyObject {
    func headerViewDidTapped(index: Int)
}
enum CollectionViewType {
    case category(model: MainSectionModel)
    case moneyTable(model: SubSectionModel)
}

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    var idx = 0
    weak var delegate: MainCollectionViewCellDelegate?
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewLayout())
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(MoneyCollectionViewCell.self, forCellWithReuseIdentifier: MoneyCollectionViewCell.identifier)
        collectionView.register(CollectionMainHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionMainHeaderView.identifier)
        collectionView.register(CollectionSubHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionSubHeaderView.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ index: Int) {
        idx = index
        flowLayout = getFlowLayout(idx)
        collectionView.reloadData()
        collectionView.collectionViewLayout = flowLayout
        configureLayout(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func configureLayout(_ view: UICollectionView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    private func getFlowLayout(_ index: Int) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        switch Sample.data[index] {
        case .category:
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 5
        case .moneyTable:
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 10
        }
        return flowLayout
    }
}

extension MainCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        switch Sample.data[idx] {
        case .category(let model):
            count = model.categorys.count
        case .moneyTable(let model):
            if model.expanded {
                count = model.payModel.count
            } else {
                count = 0
            }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Sample.data[idx] {
        case .category(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(model: model.categorys[indexPath.row])
            collectionView.backgroundColor = .clear
            return cell
        case .moneyTable(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoneyCollectionViewCell.identifier, for: indexPath) as? MoneyCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(model: model.payModel[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch Sample.data[idx] {
                case .category:
                return UICollectionReusableView()
                case .moneyTable(let model):
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionSubHeaderView.identifier, for: indexPath) as? CollectionSubHeaderView else { return UICollectionReusableView() }
                header.delegate = self
                header.configure(model: model)
                header.index = idx
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
        default:
            print("Header and Footer Error")
            return UICollectionReusableView()
        }

    }
}
extension MainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Sample.data[idx] {
        case .category:
            return CGSize(width: 50, height: self.contentView.frame.height)
        case .moneyTable:
            return CGSize(width: self.contentView.frame.width, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch Sample.data[idx] {
        case .category:
            return .zero
        case .moneyTable:
            return CGSize(width: self.contentView.frame.width, height: 100)
        }
    }
}

extension MainCollectionViewCell: CollectionSubHeaderViewDelegate {
    func resizeSection(sectionIndex: Int) {
        switch Sample.data[sectionIndex] {
        case .category(let model):
            break
        case .moneyTable(let model):
            var md = model
            md.expanded = !md.expanded
            Sample.data[sectionIndex] = .moneyTable(model: md)
        }
        delegate?.headerViewDidTapped(index: sectionIndex)
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.collectionView.reloadData()
            }
        }
        
    }
}
