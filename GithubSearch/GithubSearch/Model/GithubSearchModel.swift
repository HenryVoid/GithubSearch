//
//  GithubSearchModel.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation

enum GitHubSearch {
    
    struct Request: Encodable {
        let page: Int
        let q: String
        
        public init(page: Int, q: String) {
            self.page = page
            self.q = q
        }
    }
    
    struct Response: Decodable {
        let totalCount: Int
        let incompleteResults: Bool
        let items: [ItemResponse]

        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case incompleteResults = "incomplete_results"
            case items
        }
    }
    
    struct ItemResponse: Decodable {
        let id: Int
        let name, fullName: String
        let owner: OwnerResponse
        let itemPrivate: Bool
        let htmlURL: String
        let itemDescription: String
        let fork: Bool
        let url: String
        let createdAt, updatedAt, pushedAt: String
        let size, stargazersCount, watchersCount: Int
        let forksCount, openIssuesCount: Int
        let score: Double

        enum CodingKeys: String, CodingKey {
            case id, name
            case fullName = "full_name"
            case owner
            case itemPrivate = "private"
            case htmlURL = "html_url"
            case itemDescription = "description"
            case fork, url
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case pushedAt = "pushed_at"
            case size
            case stargazersCount = "stargazers_count"
            case watchersCount = "watchers_count"
            case forksCount = "forks_count"
            case openIssuesCount = "open_issues_count"
            case score
        }
        
        public func toGitHubRepoItem() -> Main.GitHubRepoItem {
            return .init(
                id: self.id,
                name: self.name,
                fullName: self.fullName,
                owner: self.owner.toGitHubRepoOwner(),
                itemPrivate: self.itemPrivate,
                htmlURL: self.htmlURL,
                itemDescription: self.itemDescription,
                fork: self.fork,
                url: self.url,
                createdAt: self.createdAt,
                updatedAt: self.updatedAt,
                pushedAt: self.pushedAt,
                size: self.size,
                stargazersCount: self.stargazersCount,
                watchersCount: self.watchersCount,
                forksCount: self.forksCount,
                openIssuesCount: self.openIssuesCount,
                score: self.score
            )
        }
    }
    
    struct OwnerResponse: Decodable {
        let login: String
        let id: Int
        let avatarURL: String
        let gravatarID: String
        let url, receivedEventsURL: String
        let type: String

        enum CodingKeys: String, CodingKey {
            case login, id
            case avatarURL = "avatar_url"
            case gravatarID = "gravatar_id"
            case url
            case receivedEventsURL = "received_events_url"
            case type
        }
        
        public func toGitHubRepoOwner() -> Main.GitHubRepoOwner {
            return .init(
                login: self.login,
                id: self.id,
                avatarURL: self.avatarURL,
                gravatarID: self.gravatarID,
                url: self.url,
                receivedEventsURL: self.receivedEventsURL,
                type: self.type
            )
        }
    }
}
