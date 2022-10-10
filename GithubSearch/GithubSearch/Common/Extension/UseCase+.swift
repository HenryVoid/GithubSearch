//
//  UseCase+.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation

protocol UseCase {
    
}

extension UseCase {
    func isNotError(_ error: Error?) -> Bool {
        return error == nil
    }
}
