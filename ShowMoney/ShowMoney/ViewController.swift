//
//  ViewController.swift
//  ShowMoney
//
//  Created by 이민재 on 4/14/24.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var data: [PayModel] = [
        PayModel(name: "짜장", money: 20000),
        PayModel(name: "짬뽕", money: 25000)
    ]
    var sections: [CellModel] = []
    var copySections: [CellModel] = []
    var sectionIndex = 0
    var expandedArr: [Bool] = []
    func addData() {
        sections.append(CellModel(cellType:
            .mainCellType(model: MainSectionModel(name: "1000000000",
                                                  categorys: [MainCategory(name: "hi"),
                                                              MainCategory(name: "nice")
                                                                                                                  ]))))
        sections.append(CellModel(cellType: .subCellType(model: SubSectionModel(categoryName: "식비",
                                                                                 totalMoney: 2000000,
                                                                                 percent: 40,
                                                                                 payModel: [PayModel(name: "짜장",
                                                                                                     money: 20000),
                                                                                 PayModel(name: "짬뽕", money: 15000)]
                                                                                 ))))
        sections.append(CellModel(cellType: .subCellType(model: SubSectionModel(categoryName: "식비2",
                                                                                 totalMoney: 2000000,
                                                                                 percent: 40,
                                                                                 payModel: [
                                                                                    PayModel(name: "탕수육",
                                                                                            money: 20000),
                                                                                    PayModel(name: "볶음밥",
                                                                                             money: 15000),
                                                                                    PayModel(name: "단무지",
                                                                                             money: 2000)]
                                                                                 ))))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addView()
        configureConstraints()
        addData()
        expandedArr = Array(repeating: false, count: sections.count)
        copySections = sections
        
//        for i in 0..<expandedArr.count {
//            if i == 0 { continue }
//            resizeSection(sectionIndex: i)
//        }
    }
    private func addView() {
        makeCollectionView()
        
    }
    private func configureConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

// MARK: - CompotionalLayout
extension ViewController {
    private func makeCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex,_) -> NSCollectionLayoutSection? in
            return self.createSection(for: sectionIndex)
        }
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        let lout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        registerCells()
        view.addSubview(collectionView)
        
    }
    
    private func registerCells() {
        self.collectionView.register(CollectionMainViewCell.self, forCellWithReuseIdentifier: CollectionMainViewCell.identifier)
        self.collectionView.register(CollectionSubViewCell.self, forCellWithReuseIdentifier: CollectionSubViewCell.identifier)
        self.collectionView.register(CollectionMainHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionMainHeaderView.identifier)
        self.collectionView.register(CollectionSubHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionSubHeaderView.identifier)
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0:
            return createMainSection(weightConstant: sectionIndex)
        default:
            return createSubSection(weightConstant: sectionIndex)
        }
    }
    
    private func createMainSection(weightConstant: Int) -> NSCollectionLayoutSection {
        let weight = (Double(weightConstant) * 0.05)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.07))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(10.0)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createSubSection(weightConstant: Int) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.05))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(10.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5.0
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}


// MARK: - CollectionView Datasouce Delegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var model: CellType?
        model = sections[section].cellType
        var count = 0
        switch model {
        case .mainCellType(let model):
            if section == 0 {
                count = model.categorys.count
            }
        case .subCellType(let model):
            if section != 0 {
                count = model.payModel.count
            }
        default:
            break
        }
        return count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    // MARK: CellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var md = sections[indexPath.section].cellType
        
        switch md {
        case .mainCellType(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionMainViewCell.identifier,
                for: indexPath) as? CollectionMainViewCell else {
                return UICollectionViewCell()
            }
            print("main: \([IndexPath(item: indexPath.row, section: indexPath.section)])")
            cell.configure(model: model.categorys[indexPath.row])
            return cell
        case .subCellType(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionSubViewCell.identifier,
                for: indexPath) as? CollectionSubViewCell else {
                return UICollectionViewCell()
            }
            print("sub\(model.categoryName): \([IndexPath(item: indexPath.row, section: indexPath.section)])")
            cell.configure(model:model.payModel[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }

    }
//        MARK: CollectionView Header & Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let model = sections[indexPath.section].cellType
        var mainHeadViewData: MainSectionModel?
        var subHeadViewData: SubSectionModel?
        switch model {
        case .mainCellType(let model):
            mainHeadViewData = model
        case .subCellType(let model):
            subHeadViewData = model
        }
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: CollectionMainHeaderView.identifier,
                                                                                   for: indexPath) as? CollectionMainHeaderView else { return UICollectionReusableView() }
                    return header
            } else {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: CollectionSubHeaderView.identifier,
                                                                                   for: indexPath) as? CollectionSubHeaderView else { return UICollectionReusableView() }
                guard let model = subHeadViewData else { return UICollectionReusableView() }
                header.index = indexPath.section
                header.configure(model: model)
                header.delegate = self
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

// MARK: - HeaderViewDelegate, Expand Cell

extension ViewController: CollectionSubHeaderViewDelegate {
    func resizeSection(sectionIndex: Int) {
        self.sectionIndex = sectionIndex

        var model = copySections[sectionIndex].cellType
        var arr: SubSectionModel?
        switch model {
        case .mainCellType(model: var model): break
        case .subCellType(model: var model):
            arr = model
        }
        if !expandedArr[sectionIndex] {
            self.collectionView.performBatchUpdates({
                self.collectionView.layoutIfNeeded()
                for i in (0..<(arr?.payModel.count)!).reversed() {
                    arr?.payModel.removeLast()
                    sections[sectionIndex].cellType = .subCellType(model: arr!)
                    self.collectionView.deleteItems(at: [IndexPath(item: i, section: sectionIndex)])
                }
            })
        } else {
            var addArr: [PayModel] = []
            self.collectionView.performBatchUpdates({
                self.collectionView.layoutIfNeeded()
                for i in (0..<(arr?.payModel.count)!) {
                    addArr.append(arr!.payModel[i])
                    sections[sectionIndex].cellType = .subCellType(model: SubSectionModel(categoryName: arr!.categoryName, totalMoney: arr!.totalMoney, percent: arr!.percent, payModel: addArr))
                    self.collectionView.insertItems(at: [IndexPath(item: i, section: sectionIndex)])
                }
            })
        }
        expandedArr[sectionIndex] = !expandedArr[sectionIndex]
    }
}
    
