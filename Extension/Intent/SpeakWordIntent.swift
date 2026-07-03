//
//  SpeakWordIntent.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import AVFAudio
import AppIntents

/// 只負責「朗讀當前單字」
struct SpeakWordIntent: AppIntent {
    
    static var title: LocalizedStringResource = "朗讀當前單字"
    
    static private let synthesizer = AVSpeechSynthesizer()

    /// 按鈕點擊後，iOS 系統會在背景悄悄執行這個 perform() 函數
    func perform() async throws -> some IntentResult {
        touchedAction()
    }
}

// MARK: - 私有API
private extension SpeakWordIntent {
    
    /// 定義點擊按鈕後要在背景執行的動作
    /// - Returns: WidgetKit 看到成功後，會自動幫你刷新 getTimeline 畫面，然後去重讀共享狀態 => 更新
    func touchedAction() -> some IntentResult {
        
        guard let allWords = Utility.shared.allWords,
              !allWords.isEmpty,
              let currentIndex = Utility.shared.currentIndex
        else {
            return .result()
        }
        
        let currentWord = allWords[currentIndex % allWords.count].word
        Utility.shared.readingWord(currentWord, language: "en-US")
        
        print("🔊 [Intent] 正在朗讀當前單字: \(currentWord)")
        return .result()
    }
}
