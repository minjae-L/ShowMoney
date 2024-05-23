//
//  MainCollectionViewCell.swift
//  ShowMoney
//
//  Created by 이민재 on 5/14/24.
//

import UIKit

// MainVC에게 대리자 지정
protocol MainCollectionViewCellDelegate: AnyObject {
    func headerViewDidTapped(index: Int)
}

class MainCollectionViewCell: UICollectionViewCell {
//    MARK: UI Property
    static let identifier = "MainCollectionViewCell"
    var idx = 0
    weak var delegate: MainCollectionViewCellDelegate?
    
    // 컬렉션 뷰 미리 만들어놓기
    private var flowLayout = UICollectionViewFlowLayout()
    private var collectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewLayout())

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(collectionView)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    MARK: Method
    // 컬렉션 뷰 기본 설정
    private func configureCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(MoneyCollectionViewCell.self, forCellWithReuseIdentifier: MoneyCollectionViewCell.identifier)
        collectionView.register(CollectionMainHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionMainHeaderView.identifier)
        collectionView.register(CollectionSubHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionSubHeaderView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    // 델리게이트 통해서 idx받고 CollectionView Layout 설정
    // idx = 0 : 카테고리, idx 1 이후로는 머니테이블
    func configure(_ index: Int) {
        idx = index
        flowLayout = getFlowLayout(idx)
        collectionView.reloadData()
        collectionView.collectionViewLayout = flowLayout
        configureLayout(collectionView)
        
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

// MARK: CollectionView Delegate, DataSource
extension MainCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // 셀 갯수 설정
    // 확장됬을땐 갯수만큼, 축소될땐 0
    // 카테고리는 제외
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
    // 셀 지정
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
    // 헤더뷰 설정 (카테고리는 제외하고 머니테이블만)
    // 머니테이블 클릭시 확장 축소
    // 확장 축소 기능을 위해 delegate
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

// MARK: CollectionView FlowLayout
extension MainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Sample.data[idx] {
        case .category:
            return CGSize(width: 50, height: self.contentView.frame.height)
        case .moneyTable:
            return CGSize(width: self.contentView.frame.width, height: 50)
        }
    }
    // 헤더 크기 (카테고리는 헤더뷰가 없음)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch Sample.data[idx] {
        case .category:
            return .zero
        case .moneyTable:
            return CGSize(width: self.contentView.frame.width, height: 100)
        }
    }
}

// MARK: Delegate
// 셀의 확장, 축소기능을 위해 대리자 위임
// HeaderSubVC -> MainCollectionViewCell -> MainViewController 순으로 데이터 전달됨
// 헤더클릭 -> 데이터 변경 -> 셀갯수 변경 -> MainVC에서 해당 셀 업데이트
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
