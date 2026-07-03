//
//  Vocabulary.swift
//  Widget
//
//  Created by William.Weng on 2026/7/3.
//

import Foundation

/// 小工具專用單字模型 (需與主 App 一致 / 符合 Codable 才能打包成 JSON 存入 UserDefaults)
struct Vocabulary: Codable {
    let word: String            // 單字
    let definition: String      // 中譯
}

// MARK: - 公用屬性
extension Vocabulary {
    
    // 占位符單字
    static let placeholder: Self = .init(word: "Intelligence", definition: "智慧")
    
    // 10 組測試單字
    static let test10Words: [Self] = [
        .init(word: "Persistent", definition: "堅持不懈的"),
        .init(word: "Efficient", definition: "高效率的"),
        .init(word: "Innovative", definition: "創新的"),
        .init(word: "Simplicity", definition: "簡約、單純"),
        .init(word: "Optimize", definition: "最佳化、優化"),
        .init(word: "Synchronize", definition: "同步"),
        .init(word: "Timeline", definition: "時間軸"),
        .init(word: "Context", definition: "上下文、語境"),
        .init(word: "Framework", definition: "框架、架構"),
        .init(word: "Extension", definition: "擴充功能")
    ]
}
