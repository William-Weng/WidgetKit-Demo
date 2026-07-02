//
//  SpeakCurrentWordIntent.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import AVFAudio
import AppIntents

// ==========================================
// 🌟 按鈕 B 的後台動作：只負責「朗讀當前單字」
// ==========================================
struct SpeakCurrentWordIntent: AppIntent {
    static var title: LocalizedStringResource = "朗讀當前單字"
    
    // 建立靜態語音合成器，防止聲音被截斷
    static let synthesizer = AVSpeechSynthesizer()

    func perform() async throws -> some IntentResult {
        let groupID = Constant.suiteName
        let sharedDefaults = UserDefaults(suiteName: groupID)
        
        // 📥 讀取單字庫與當前的 Index
        var allWords: [Vocabulary] = []
        if let savedData = sharedDefaults?.data(forKey: "all_500_words"),
           let decoded = try? JSONDecoder().decode([Vocabulary].self, from: savedData) {
            allWords = decoded
        }
        
        let currentIndex = sharedDefaults?.integer(forKey: "current_word_index") ?? 0
        
        // 🔊 取得當前的單字並進行背景發音
        if !allWords.isEmpty {
            let currentWord = allWords[currentIndex % allWords.count].word
            
            let utterance = AVSpeechUtterance(string: currentWord)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
            try? audioSession.setActive(true)
            
            Self.synthesizer.speak(utterance)
            print("🔊 [Intent] 正在朗讀當前單字: \(currentWord)")
        }
        
        // 💡 提示：因為發音不需要改變畫面 UI，所以直接回傳成功，小工具畫面不會閃爍
        return .result()
    }
}
