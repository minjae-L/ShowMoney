//
//  DataModels.swift
//  ShowMoney
//
//  Created by 이민재 on 4/16/24.
//

import Foundation

enum CollectionViewType {
    case category(model: MainSectionModel)
    case moneyTable(model: SubSectionModel)
}

struct MainSectionModel {
    let moneyGoal: String
    let categorys: [MainCategory]
}
struct MainCategory {
    let name: String
}

struct SubSectionModel {
    var categoryName: String
    var totalMoney: Int
    var percent: Int
    var expanded: Bool = false
    var payModel: [PayModel]
}

struct PayModel {
    let name: String
    let money: Int
}
// 임시 데이터
class Sample {
    static var data: [CollectionViewType] = [.category(model: MainSectionModel(moneyGoal: "1000000",
                                                                               categorys: [MainCategory(name: "bye")])),
                                             .moneyTable(model: SubSectionModel(categoryName: "식비",
                                                                                totalMoney: 100000,
                                                                                percent: 50,
                                                                                payModel: [PayModel(name: "짜장",
                                                                                                    money: 5000),
                                                                                           PayModel(name: "짬뽕",
                                                                                                    money: 2000)])),
                                             .moneyTable(model: SubSectionModel(categoryName: "식비",
                                                                                totalMoney: 100000,
                                                                                percent: 50,
                                                                                payModel: [PayModel(name: "짜장",
                                                                                                    money: 5000),
                                                                                           PayModel(name: "짬뽕",
                                                                                                    money: 2000)])),
                                             .moneyTable(model: SubSectionModel(categoryName: "식비",
                                                                                totalMoney: 100000,
                                                                                percent: 50,
                                                                                payModel: [PayModel(name: "짜장",
                                                                                                    money: 5000),
                                                                                           PayModel(name: "짬뽕",
                                                                                                    money: 2000)]))]
}
