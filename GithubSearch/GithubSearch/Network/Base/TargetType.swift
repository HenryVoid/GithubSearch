//
//  TargetType.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation
import Alamofire

public protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var contentType: ContentType { get }
}

extension TargetType {
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try baseURL.asURL()
        
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch parameters {
        case .path(let request):
            let params = request?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            
            var queryItems: [URLQueryItem] = []
            params.forEach { key, value in
                let queryItem = URLQueryItem(name: key, value: value as? String)
                queryItems.append(queryItem)
            }
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            
        case .query(let request):
            
            let params = request?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            
        case .body(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
        case .requestPlain:
            break
            
        }
        
        return urlRequest
    }
}

public extension TargetType {
    var contentType: ContentType {
        return .json
    }
}
