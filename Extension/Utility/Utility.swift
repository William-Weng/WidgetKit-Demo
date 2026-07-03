//
//  Utility.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/3.
//

import Foundation
import AVFAudio

/// Widget 共用功能
final class Utility {
    
    static var shared: Utility = .init()
    
    private let synthesizer = AVSpeechSynthesizer()
    private let sharedDefaults: UserDefaults?
    
    private init() {
        sharedDefaults = Constant.sharedDefaults
    }
}

// MARK: - 公開屬性
extension Utility {
    
    /// 取得全部儲存的單字
    var allWords: [Vocabulary]? {
        
        guard let savedData = sharedDefaults?.data(forKey: Constant.wordsKey),
              let allWords: [Vocabulary] = savedData.decoded()
        else {
            return nil
        }
        
        return allWords
    }
    
    /// 取得現在的Index
    var currentIndex: Int? {
        return sharedDefaults?.integer(forKey: Constant.indexKey)
    }
}

// MARK: - 公開API
extension Utility {
    
    /// 朗讀單字
    /// - Parameters:
    ///   - word: 單字
    ///   - language: 使用語系
    func readingWord(_ word: String, language: String) {
        
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        
        setAudioSession()
        synthesizer.speak(utterance)
    }
    
    /// 更新單字的序號Index (循環不溢位)
    /// - Parameters:
    ///   - totalCount: 總字數
    ///   - defaults: UserDefaults
    /// - Returns: 下一個Index
    func updateIndex() -> Int? {
        
        guard let sharedDefaults = sharedDefaults,
              let allWords = allWords,
              let currentIndex = currentIndex
        else {
            return nil
        }
        
        let nextIndex = (currentIndex + 1) % allWords.count
        sharedDefaults.set(nextIndex, forKey: Constant.indexKey)
        
        return nextIndex
    }
    
    /// 取得下一個單字 (循環不溢位)
    /// - Parameter step: 下幾個
    /// - Returns: 單字
    func nextWord(step: Int) -> Vocabulary? {
        
        guard let allWords = Utility.shared.allWords,
              let currentIndex = Utility.shared.currentIndex
        else {
            return nil
        }
        
        return allWords[(currentIndex + step) % allWords.count]
    }
}

// MARK: - 私有API
private extension Utility {
    
    /// 設定AVAudioSession的使用情境
    func setAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
        try? audioSession.setActive(true)
    }
}
