//
//  MainModel.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation
import RxDataSources

enum Main {
    enum Item {
        case searchRepo(GitHubRepoItem)
    }
    
    enum Section {
        case searchRepo(title: String, items: [Item])
        
    }
    
    struct GitHubRepoItem {
        let id: Int
        let name, fullName: String
        let owner: GitHubRepoOwner
        let itemPrivate: Bool
        let htmlURL: String
        let itemDescription: String
        let fork: Bool
        let url: String
        let createdAt, updatedAt, pushedAt: String
        let size, stargazersCount, watchersCount: Int
        let forksCount, openIssuesCount: Int
        let score: Double
    }
    
    struct GitHubRepoOwner {
        let login: String
        let id: Int
        let avatarURL: String
        let gravatarID: String
        let url, receivedEventsURL: String
        let type: String
    }
}

extension Main.Section: SectionModelType {
    typealias Item = Main.Item
    
    var items: [Item] {
        switch self {
        case .searchRepo(_, let items):
            return items
        }
    }
    var title: String {
        switch self {
        case .searchRepo(let title, _):
            return title
        }
    }
    
    init(original: Main.Section, items: [Item]) {
        switch original {
        case .searchRepo(let title, let items):
            self = .searchRepo(title: title, items: items)
        }
    }
}
