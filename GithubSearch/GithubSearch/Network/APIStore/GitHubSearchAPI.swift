//
//  GitHubSearchAPI.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation

protocol GitHubSearchServiceType {
    func search(dto: GitHubSearch.Request) async throws -> GitHubSearch.Response?
}

enum GitHubSearchAPI {
    case search(GitHubSearch.Request)
}

extension GitHubSearchAPI: TargetType {
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/repositories"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .search(let request):
            return .path(request)
        }
    }
}

class GitHubSearchService: BaseAPI<GitHubSearchAPI>, GitHubSearchServiceType {
    func search(
        dto: GitHubSearch.Request,
        completion: @escaping (GitHubSearch.Response?, Error?) -> Void
    ) {
        self.fetchData(
            target: .search(dto),
            responseData: GitHubSearch.Response.self
        ) { result, error in
            completion(result, error)
        }
    }
}

