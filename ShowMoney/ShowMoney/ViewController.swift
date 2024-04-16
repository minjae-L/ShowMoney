//
//  ViewController.swift
//  ShowMoney
//
//  Created by 이민재 on 4/14/24.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var total = [[],
                ["hi", "nice", "to", "meet", "you"],
                ["what", "sup", "guys"],
                ["how", "are", "you"]
                ]
    var addTotal = [[],
                ["hi", "nice", "to", "meet", "you"],
                ["what", "sup", "guys"],
                ["how", "are", "you"]
                ]
    var sectionIndex = 0
    var expandedArr: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addView()
        configureConstraints()
        expandedArr = Array(repeating: true, count: 10)
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

// MARK: - CollectionView CompotionalLayout
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
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
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
        section.interGroupSpacing = 15.0
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createSubSection(weightConstant: Int) -> NSCollectionLayoutSection {
        let weight = (Double(weightConstant) * 0.05)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(10.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15.0
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}


// MARK: - CollectionView Datasouce Delegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return total[section].count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return total.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.section == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .green
        }
        cell.label.text = total[indexPath.section][indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
                header.index = indexPath.section
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
    // 셀버튼 클릭
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - HeaderView Action

extension ViewController: CollectionSubHeaderViewDelegate {
    func resizeSection(sectionIndex: Int) {
        self.sectionIndex = sectionIndex
        print("tap")
        
        // 수축되어있을때,
        if expandedArr[sectionIndex] {
            print("expanded: \(expandedArr[sectionIndex])")
            expandedArr[sectionIndex] = !expandedArr[sectionIndex]
            self.collectionView.performBatchUpdates({
                self.collectionView.layoutIfNeeded()
                for i in (0..<total[sectionIndex].count).reversed() {
                    self.total[sectionIndex].remove(at: i)
                    self.collectionView.deleteItems(at: [IndexPath(item: i, section: sectionIndex)])
                }
                
            }, completion: nil)
            print(total)
        } else {
            // 팽창되어있을때
            print("expanded: \(expandedArr[sectionIndex])")
            expandedArr[sectionIndex] = !expandedArr[sectionIndex]
            self.collectionView.performBatchUpdates({
                self.collectionView.layoutIfNeeded()
                for i in 0..<self.addTotal[sectionIndex].count {
                    self.total[sectionIndex].append(addTotal[sectionIndex][i])
                    print(addTotal[sectionIndex][i])
                    self.collectionView.insertItems(at: [IndexPath(item: i, section: sectionIndex)])
                }
            }, completion: nil)
            print(total)
        }
        
    }
}
    
