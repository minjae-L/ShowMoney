//
//  DataModels.swift
//  ShowMoney
//
//  Created by 이민재 on 4/16/24.
//

import Foundation

struct CellModel {
    let cellType: [CellType]
}

enum CellType {
    case mainCellType(model: MainSectionModel)
    case subCellType(model: SubSectionModel)
}

struct MainSectionModel {
    let name: String
    let categorys: [MainCategory]
}
struct MainCategory {
    let name: String
}

struct SubSectionModel {
    var categoryName: String
    var totalMoney: Int
    var percent: Int
    var payModel: [PayModel]
}

struct PayModel {
    let name: String
    let money: Int
}
