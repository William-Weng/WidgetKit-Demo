//
//  ChangeWordIntent.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import AppIntents

// 互動按鈕必備框架 - AppIntents (iOS 17+ 互動按鈕必備框架)
struct ChangeWordIntent: AppIntent {
        
    static var title: LocalizedStringResource = "換下一個單字"    // 必須為這個意圖設定一個唯一的標題
    
    /// 按鈕點擊後，iOS 系統會在背景悄悄執行這個 perform() 函數
    func perform() async throws -> some IntentResult {
        touchedAction()
    }
}

// MARK: - 私有API
private extension ChangeWordIntent {
    
    /// 定義點擊按鈕後要在背景執行的動作
    /// - Returns: WidgetKit 看到成功後，會自動幫你刷新 getTimeline 畫面，然後去重讀共享狀態 => 更新
    func touchedAction() -> some IntentResult {
        
        guard let allWords = Utility.shared.allWords,
              !allWords.isEmpty,
              let nextIndex = Utility.shared.updateIndex()
        else {
            return .result()
        }
        
        print("🚀 [Intent] 使用者點擊了按鈕，Index 已切換至: \(nextIndex)")
        return .result()
    }
}
