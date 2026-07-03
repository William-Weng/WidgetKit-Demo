//
//  SimpleEntry.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import WidgetKit

/// 小工具的時間軸 Entry
struct SimpleEntry: TimelineEntry {
    let date: Date              // 時間 (更新用)
    let word: String            // 單字
    let definition: String      // 中譯
}

// MARK: - 公開屬性
extension SimpleEntry {
    
    // 時間軸占位符單字 (空資料時)
    static var placeholder: Self {
        .init(date: .now, word: Vocabulary.placeholder.word, definition: Vocabulary.placeholder.definition)
    }

    // 展示用單字 (新增Widget時)
    static var snapshot: Self {
        .init(date: .now, word: "Efficient", definition: "高效率的")
    }
}
