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
        widgetTouchedAction()
    }
}

// MARK: - 私有API
private extension ChangeWordIntent {
    
    /// 定義點擊按鈕後要在背景執行的動作
    /// - Returns: WidgetKit 看到成功後，會自動幫你刷新 getTimeline 畫面
    func widgetTouchedAction() -> some IntentResult {
        
        let sharedDefaults = UserDefaults(suiteName: Constant.groupID)
        
        // 📥 讀取目前的單字總數，用來計算餘數防溢出
        var totalCount = 10
        if let savedData = sharedDefaults?.data(forKey: "all_500_words"),
           let allWords = try? JSONDecoder().decode([Vocabulary].self, from: savedData) {
            totalCount = allWords.count
        }
        
        // 📥 讀取當前 Index，並直接 +1 存回去
        let currentIndex = sharedDefaults?.integer(forKey: "current_word_index") ?? 0
        let nextIndex = (currentIndex + 1) % totalCount
        sharedDefaults?.set(nextIndex, forKey: "current_word_index")
        
        print("🚀 [Intent] 使用者點擊了按鈕，Index 已切換至: \(nextIndex)")
        
        return .result()
    }
}
