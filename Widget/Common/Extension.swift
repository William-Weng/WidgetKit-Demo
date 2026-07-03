//
//  Extension.swift
//  Widget
//
//  Created by William.Weng on 2026/7/3.
//

import Foundation

// MARK: - Collection
extension Collection where Self: Encodable {
    
    /// 將集合打包成 JSON Data
    /// - Returns: Data
    func encoded() throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return data
    }
}

// MARK: - Data
extension Data {
    
    /// 將 Data 解回 Collection
    /// - Parameter data: Data
    /// - Returns: [T]?
    func decoded<T: Decodable>() -> [T]? {
        try? JSONDecoder().decode([T].self, from: self)
    }
}

// MARK: - URL
extension URL {
    
    /// 尋找Query的參數值 (wordie://word?id=123&difficulty=easy => ["difficulty": "easy"] => "easy")
    /// - Parameter key: 參數名稱
    /// - Returns: String?
    func queryValue(for key: String) -> String? {
        
        URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first(where: { $0.name == key })?
            .value
    }
}
