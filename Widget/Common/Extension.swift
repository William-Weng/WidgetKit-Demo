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
