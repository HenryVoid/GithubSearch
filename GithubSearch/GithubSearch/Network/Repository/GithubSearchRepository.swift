//
//  GithubSearchRepository.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation

protocol GitHubSearchRepositoryType {
    func search(
        page: Int,
        keyword: String,
        completion: @escaping (GitHubSearch.Response?, Error?) -> Void
    )
}

final class GitHubSearchRepository: GitHubSearchRepositoryType {
    
    private let api = GitHubSearchService()
    
    public init() {}
    
    public func search(
        page: Int,
        keyword: String,
        completion: @escaping (GitHubSearch.Response?, Error?) -> Void
    ) {
        self.api.search(
            dto: .init(page: page, q: keyword)
        ) { result, error in
            if let result = result {
                completion(result, error)
            } else {
                completion(nil, error)
            }
            
        }
    }
}

extension GitHubSearchRepository {
    
}
