//
//  RequestParams.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation

public enum RequestParams {
    case requestPlain
    case path(_ parameter: Encodable?)
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
}
