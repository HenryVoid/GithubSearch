//
//  BaseAPI.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    let coniguration: URLSessionConfiguration
    let session: Session
    let apiLogger = APIEventLogger()
    
    init(
        configuration: URLSessionConfiguration = .default
    ) {
        
        self.coniguration = configuration
        self.session = Session(configuration: configuration, eventMonitors: [self.apiLogger])
    }
    
    func fetchData<M: Decodable>(
        target: T,
        responseData: M.Type,
        completionHandler: @escaping (M?, Error?) -> Void
    ) {
        
        let session = self.session
        
        session.request(target)
            .responseDecodable(of: M.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(data, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
    }
}
