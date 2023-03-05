//
//  URLInfo+SearchAPI.swift
//  GithubSearch
//
//  Created by 송형욱 on 2023/03/05.
//

import Foundation

extension NetworkAPI.URLInfo {
    static func SearchAPI() -> Self {
        Self.init(host: "api.github.com", path: "search/repositories")
    }
}
