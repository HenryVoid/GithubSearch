//
//  Encodable+.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation

extension Encodable {
  func toDictionary() -> [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let jsonData = try? JSONSerialization.jsonObject(with: data),
          let dictionaryData = jsonData as? [String: Any] else { return [:] }
    return dictionaryData
  }
}
