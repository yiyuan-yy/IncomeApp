//
//  PreviewFactory.swift
//  IncomeApp
//
//  Created by yiyuan hu on 12/15/25.
//
import RealmSwift

enum RealmConfig {
    static let preivew: Realm.Configuration = {
        var config = Realm.Configuration()
        config.inMemoryIdentifier = "preview-realm"
        return config
    }()
}

@MainActor
enum PreviewFactory {
    static func makeViewModel(setting: SettingStore) -> TransactionViewModel {
        let realm = try! Realm(configuration: RealmConfig.preivew)
        insertPreviewData(realm: realm)
        let repo = TransactionRepository(realm: realm)
        return TransactionViewModel(settings: setting, repository: repo)
    }
}

@MainActor
func insertPreviewData(realm: Realm) {
    let samples = [
        TransactionObject(
            title: "Coffee",
            amount: 4.5,
            type: .expense,
            date: .now
        ),
        TransactionObject(
            title: "Salary",
            amount: 3000,
            type: .income,
            date: .now
        )
    ]

    try? realm.write {
        realm.add(samples)
    }
}
