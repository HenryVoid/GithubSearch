//
//  SearchAPI+Repository.swift
//  GithubSearch
//
//  Created by 송형욱 on 2023/03/05.
//

import Foundation

extension SearchAPI {
    struct Repository: NetworkAPIProtocol {
        typealias Parameter = GitHubSearch.Request
        typealias Response = GitHubSearch.Response
        
        let urlInfo: URLInfo
        let requestInfo: RequestInfo<GitHubSearch.Request>
        
        init(request: GitHubSearch.Request) {
            self.requestInfo = .init(method: .get,
                                     parameters: .init(
                                        page: request.page,
                                        q: request.q
                                     ))
            self.urlInfo = .SearchAPI()
        }
    }
}
