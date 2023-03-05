//
//  NetworkAPIProtocol.swift
//  GithubSearch
//
//  Created by 송형욱 on 2023/03/05.
//

import Foundation

protocol NetworkAPIProtocol {
    typealias URLInfo = NetworkAPI.URLInfo
    typealias RequestInfo = NetworkAPI.RequestInfo
    
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable
    
    var urlInfo: URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
}
